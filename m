Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B624C3FBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 09:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiBYIFv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 03:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiBYIFu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 03:05:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5919F460;
        Fri, 25 Feb 2022 00:05:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8710261BA7;
        Fri, 25 Feb 2022 08:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156CBC340E7;
        Fri, 25 Feb 2022 08:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645776318;
        bh=R8Z4PS4bqFbVj1m0cBD53CKo7jMpJ9THvKAGLBQf9oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=SPkRrLaOLKMIxxH9f9JcRA6CW6sx836DiPSgqMMrnYIvCE/O5XlpRLSzNRyKOCgFR
         khzLwdIlspdVyx9yDgJwzbLTpXRqEcsrOYbKPCXz2VvPsj+ga4/HZEiGa8SIdcPso/
         VCdGejyWK5f2jPvWuq7vNh8gtCGjBdS9Qa8VrGq27sZqrP6wBKx2cHxXGswpu/NjDV
         XUL5Aml+wxOZuOQyf2/NA/XvOt6TJPdwKZDxQkACB+O6GlFuYLtGnP3HdpQPp5SRUT
         XLHcrVXLQxD6CVPevUf0oWCafdt0LwLKo1xU3jbkrhmLIyHRYSuQHJHm1oR2c81jmc
         m4Jy9WNn8uSmg==
From:   SeongJae Park <sj@kernel.org>
To:     xhao@linux.alibaba.com
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] Introduce DAMON sysfs interface
Date:   Fri, 25 Feb 2022 08:05:13 +0000
Message-Id: <20220225080513.1908-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <1dbf6a7e-0805-bc44-ec4b-379405d619d1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Xin,

On Fri, 25 Feb 2022 15:32:47 +0800 xhao@linux.alibaba.com wrote:

> Hi SeongJae:
> 
> On 2/23/22 11:20 PM, SeongJae Park wrote:
[...]
> > Introduction
> > ============
> >
> > DAMON's debugfs-based user interface (DAMON_DBGFS) served very well, so far.
> > However, it unnecessarily depends on debugfs, while DAMON is not aimed to be
> > used for only debugging.  Also, the interface receives multiple values via one
> > file.  For example, schemes file receives 18 values.  As a result, it is
> > inefficient, hard to be used, and difficult to be extended.  Especially,
> > keeping backward compatibility of user space tools is getting only challenging.
> > It would be better to implement another reliable and flexible interface and
> > deprecate DAMON_DBGFS in long term.
> >
> > For the reason, this patchset introduces a sysfs-based new user interface of
> > DAMON.  The idea of the new interface is, using directory hierarchies and
> > having one dedicated file for each value.  For a short example, users can do
> > the virtual address monitoring via the interface as below:
> >
> >      # cd /sys/kernel/mm/damon/admin/
> >      # echo 1 > kdamonds/nr
> >      # echo 1 > kdamonds/0/contexts/nr
> >      # echo vaddr > kdamonds/0/contexts/0/operations
> >      # echo 1 > kdamonds/0/contexts/0/targets/nr
> >      # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
> >      # echo on > kdamonds/0/state
> >
> > A brief representation of the files hierarchy of DAMON sysfs interface is as
> > below.  Childs are represented with indentation, directories are having '/'
> > suffix, and files in each directory are separated by comma.
> >
> >      /sys/kernel/mm/damon/admin
> >      │ kdamonds/nr
> >      │ │ 0/state,pid
> >      │ │ │ contexts/nr
> >      │ │ │ │ 0/operations
> >      │ │ │ │ │ monitoring_attrs/
> >      │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> >      │ │ │ │ │ │ nr_regions/min,max
> >      │ │ │ │ │ targets/nr
> >      │ │ │ │ │ │ 0/pid
> >      │ │ │ │ │ │ │ regions/nr
> >      │ │ │ │ │ │ │ │ 0/start,end
> >      │ │ │ │ │ │ │ │ ...
> >      │ │ │ │ │ │ ...
> >      │ │ │ │ │ schemes/nr
> >      │ │ │ │ │ 0/action
> >      │ │ │ │ │ │ access_pattern/
> >      │ │ │ │ │ │ │ sz/min,max
> >      │ │ │ │ │ │ │ nr_accesses/min,max
> >      │ │ │ │ │ │ │ age/min,max
> >      │ │ │ │ │ │ quotas/ms,sz,reset_interval_ms
> >      │ │ │ │ │ │ │ weights/sz,nr_accesses,age
> >      │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
> >      │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
> >      │ │ │ │ │ ...
> >      │ │ ...
> >
> > Detailed usage of the files will be described in the final Documentation patch
> > of this patchset.
> 
> The introduction of the sys DAMON interface makes DAMON seem more 
> hierarchical, but it brings a problem. From a user's perspective,
> 
> I find it difficult to operate. For example:
> 
> step one:
> 
> echo xxx > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr
> 
> step two:
> 
> echo /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr/1/pid
> 
> echo /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr/0/pid
> 
> .........
> 
> Alas, it is really too troublesome to operate, can you make it as simple 
> as possible, perhaps by referring to the implementation of cgroup.

Thank you very much for the great comments.  I agree that this interface
requires quite a redundant works.  Nevertheless, this interface is not aimed to
be used by human hand but user space tools.  We provide the DAMON user-space
tool, damo, for the purpose.  Damo already supports this interface while
introducing nearly-zero change to the end user interface.  All you need to do
to use sysfs in background with damo is adding '--damon_interface sysfs' to the
command.

I guess someone might still want low level sysfs control for development and
testing purpose.  For the case, damo is providing a new subcommand, fs[1], for
more low level sysfs control with better interface.  It allows users to
read/write all hierarchies and values in DAMON sysfs via json format.  For
example:

    # ./damo/damo fs --damon_interface sysfs read
    {
        "kdamonds": {
            "0": {
                "contexts": {
                    "nr_contexts": "0\n"
                },
                "pid": "-1\n",
                "state": "off\n"
            },
            "nr_kdamonds": "1\n"
        }
    }
    # cat content.json
    {
        "kdamonds": {
            "0": {
                "contexts": {
                    "nr_contexts": "1\n"
                }
            }
        }
    }
    # ./damo/damo fs --damon_interface sysfs write --content "$(cat content.json)"
    # ./damo/damo fs --damon_interface sysfs read
    {
        "kdamonds": {
            "0": {
                "contexts": {
                    "0": {
                        "monitoring_attrs": {
                            "intervals": {
                                "aggr_us": "100000\n",
                                "sample_us": "5000\n",
                                "update_us": "60000000\n"
                            },
                            "nr_regions": {
                                "max": "1000\n",
                                "min": "10\n"
                            }
                        },
                        "operations": "vaddr\n",
                        "schemes": {
                            "nr_schemes": "0\n"
                        },
                        "targets": {
                            "nr_targets": "0\n"
                        }
                    },
                    "nr_contexts": "1\n"
                },
                "pid": "-1\n",
                "state": "off\n"
            },
            "nr_kdamonds": "1\n"
        }
    }

I admit damo interface is still not perfect.  It has many rooms for
improvement.

If even damo is too heavyweight for you, you could use some general scripts
that can do above work in similar manner:
https://github.com/sjp38/lazybox/blob/master/scripts/fs.py


Thanks,
SJ
