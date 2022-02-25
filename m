Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0C34C3FC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 09:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiBYILD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 03:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiBYILD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 03:11:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C4882D1C;
        Fri, 25 Feb 2022 00:10:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A984F61BEF;
        Fri, 25 Feb 2022 08:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D13DC340E7;
        Fri, 25 Feb 2022 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645776627;
        bh=M4USnKyDoarCLAxcj1URQPBkgtFfHFlk4iSdKCZvhDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=UAEdRQDpfxyMq22KEHqXjb2MSXT45ERk5n65VvbAVYMpGvJF2emahbmmx8FCEcaWo
         IBZj1FH+v+jljfDybUB2oX/ziJbvr458jFZUU/LCHrJtVOEj55YFm4pOz3+qr40Td5
         uVu28mVrlu9wkKlEb4dQb4mmvy6AIeO4SE7ukOOIrVKDgJ0hlemya2PJmdr58Es1G/
         8/PmuB9BY/fbAIB1lHpSLa1/sz3lFnU7sWIEAgCgptikkt2IJjQrn9sn2w+xsS2JWy
         XGrzsQG/ACQ3uwhDufUPV/+CQznIr4MdGjYLX/D9nCi+U6/UU1lfPWoRAid6ydhRzJ
         /TYBZFQERCYPw==
From:   SeongJae Park <sj@kernel.org>
To:     xhao@linux.alibaba.com
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] mm/damon: Implement a minimal stub for sysfs-based DAMON interface
Date:   Fri, 25 Feb 2022 08:10:24 +0000
Message-Id: <20220225081024.1979-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <66331451-48d8-6658-cdce-6e79df27ae5e@linux.alibaba.com>
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

On Fri, 25 Feb 2022 15:21:05 +0800 xhao@linux.alibaba.com wrote:

> Hi, SeongJae:
> 
> On 2/23/22 11:20 PM, SeongJae Park wrote:
> > DAMON's debugfs-based user interface served very well, so far.  However,
> > it unnecessarily depends on debugfs, while DAMON is not aimed to be used
> > for only debugging.  Also, the interface receives multiple values via
> > one file.  For example, schemes file receives 18 values separated by
> > white spaces.  As a result, it is ineffient, hard to be used, and
> > difficult to be extended.  Especially, keeping backward compatibility of
> > user space tools is getting only challenging.  It would be better to
> > implement another reliable and flexible interface and deprecate the
> > debugfs interface in long term.
> >
> > To this end, this commit implements a stub of a part of the new user
> > interface of DAMON using sysfs.  Specifically, this commit implements
> > the sysfs control parts for virtual address space monitoring.
> >
> > More specifically, the idea of the new interface is, using directory
> > hierarchies and making one file for one value.  The hierarchy that this
> > commit is introducing is as below.  In the below figure,
> > parents-children relations are represented with indentations, each
> > directory is having ``/`` suffix, and files in each directory are
> > separated by comma (",").
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
> >      │ │ │ │ │ │ ...
> >      │ │ │ │ ...
> >      │ │ ...
> 
> >
> > Writing a number <N> to each 'nr' file makes directories of name <0> to
> > <N-1> in the directory of the 'nr' file.  That's all this commit does.
> > Writing proper values to relevant files will construct the DAMON
> > contexts, and writing a special keyword, 'on', to 'state' files for each
> > kdamond will ask DAMON to start the constructed contexts.
> >
> > For a short example, using below commands for
> > monitoring virtual address spaces of a given workload is imaginable:
> >
> >      # cd /sys/kernel/mm/damon/admin/
> >      # echo 1 > kdamonds/nr
> >      # echo 1 > kdamonds/0/contexts/nr
> >      # echo vaddr > kdamonds/0/contexts/0/damon_type
> >      # echo 1 > kdamonds/0/contexts/0/targets/nr
> >      # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
> >      # echo on > kdamonds/0/state
> 
> I do some test  about the sys interface, like this:
> 
> [root@rt2k03395 0]# tree
> .
> ├── contexts
> │   ├── 0
> │   │   ├── monitoring_attrs
> │   │   │   ├── intervals
> │   │   │   │   ├── aggr_us
> │   │   │   │   ├── sample_us
> │   │   │   │   └── update_us
> │   │   │   └── nr_regions
> │   │   │       ├── max
> │   │   │       └── min
> │   │   ├── operations
> │   │   ├── schemes
> │   │   │   └── nr
> │   │   └── targets
> │   │       ├── 0
> │   │       │   ├── pid
> │   │       │   └── regions
> │   │       │       ├── 0
> │   │       │       │   ├── end
> │   │       │       │   └── start
> │   │       │       ├── 1
> │   │       │       │   ├── end
> │   │       │       │   └── start
> │   │       │       ├── 10
> │   │       │       │   ├── end
> │   │       │       │   └── start
> │   │       │       ├── 11
> │   │       │       │   ├── end
> │   │       │       │   └── start
> │   │       │       ├── 12
> 
> cd regions/
> [root@rt2k03395 regions]# ls
> 0  10  12  14  16  18  2   21  23  25  27  29  30  32  34  36  38 4   
> 41  43  45  47  49  6  8  nr
> 1  11  13  15  17  19  20  22  24  26  28  3   31  33  35  37  39 40  
> 42  44  46  48  5   7  9
> [root@rt2k03395 regions]# cd 44/cat *
> 
> [root@rt2k03395 regions/44]# cat *
> 0  0
> 
> I'm skeptical about the number regions ? And after manually setting the 
> number of nr, the processing of
> 
> "start" and "end" will be very troublesome,I guess you might want to do 
> some special region addresses,
> 
> such as hot or cold region, Is that true ？

The purpose of regions/ directory is for supporting the initial monitoring
regions feature of debugfs, which is optional for virtual address spaces
monitoring, but essential for physical address space monitoing.  If you need to
monitor only virtual address spaces, you don't need to populate the directory.

In a future, we could add nr_accesses and age files under each region directory
and apply the monitoring results there.


> But I think you need to think 
> about how do you deal with too many
> 
> uncontacted reigons that need to be done.

Sysfs interface is not aimed to be used by human hand but user space tools, and
we provide a reference tool, damo.  Please consider using that or implement
your own.  You could also refer to my reply to your other email for this point:
https://lore.kernel.org/linux-mm/20220225080513.1908-1-sj@kernel.org/


Thanks,
SJ
[...]
