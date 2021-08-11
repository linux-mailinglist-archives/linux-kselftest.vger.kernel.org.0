Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1723B3E98B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 21:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhHKT1t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 15:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230207AbhHKT1s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 15:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628710044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiwffSXoiH4DxwCpTg6qh9csw8fx7R1FkfmT6DZocnc=;
        b=CyRliTBNRNsLfXCLTY0EZhKVS21jvL2Auc5Su/LojcjPOGhDuJb8oK8MspIiOaWKGufPHS
        f395vfpoq1a7DDL7mzKS0xQrRYROn1GXoOvuv8C2jebsJhIIWSxWZKJfFr5hu6hFsGZ//i
        Utgy7nBiX1XbbKhTFeErpfi+s4xw7ZI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-X4GDbfwTOfKvQd71CMv0ow-1; Wed, 11 Aug 2021 15:27:23 -0400
X-MC-Unique: X4GDbfwTOfKvQd71CMv0ow-1
Received: by mail-qt1-f199.google.com with SMTP id x15-20020ac87a8f0000b0290294d1eeaa1dso1850152qtr.13
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Aug 2021 12:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tiwffSXoiH4DxwCpTg6qh9csw8fx7R1FkfmT6DZocnc=;
        b=bxzqugZ3MgfXO04TD21hHQQOuJ0WpHLcrurvouRGNWdy+T7KGAfzHAqc7O5+qjCUss
         OEuy9R5MyX+sgrOTV2xvD8vITUYzJN+wBzBhoaeLQ9iWKvZTxjVxCb7r3ghZiyzwlUI1
         YMfT8i21kuv0pwpfPPnPsfFuuqS+57JhxV+kXCko363Aiu8wi5PKLs8YKO4B5lJxmOD0
         MXxBB4JX+MzNp9NNZSwBTzDVSPUFRyElxAYJpKGY3+o9Uk5Pwq3beWNgxsSqKpDkFzpg
         zWY5SblTrPhQoEIJpQW+01VmKvp6r4nENFZ16sCIplJV9RzA4Tr8k2KITkptigbfRCvv
         n4SQ==
X-Gm-Message-State: AOAM5332Rke8V9C5jCswSuyV5menbnMja4/csjV6QidrflRVV/murAcO
        adGoBFBMjTtqiJVAGqxfyfrQt6qVls3xVdqTjQK4pljpkq4zlJJjAJs9AT0k0H3e4jx0diUu/vc
        QXKW94kJamlIX1DieOG+Mty0auE+B
X-Received: by 2002:a05:6214:528a:: with SMTP id kj10mr223845qvb.38.1628710042540;
        Wed, 11 Aug 2021 12:27:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpq/PfA7+2XCpTTT9aRZ2gHbPglInuSLcGqqGbvnQp/UX636wyca1IWuYEvOy4vg/NuCUfRQ==
X-Received: by 2002:a05:6214:528a:: with SMTP id kj10mr223832qvb.38.1628710042306;
        Wed, 11 Aug 2021 12:27:22 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n11sm45000qkk.93.2021.08.11.12.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 12:27:21 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 2/6] cgroup/cpuset: Properly handle partition root tree
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-3-longman@redhat.com>
 <YRQSKZB8rQUsfF2K@slm.duckdns.org>
Message-ID: <b7897818-8fe6-8dd8-3ff6-6b15401162ba@redhat.com>
Date:   Wed, 11 Aug 2021 15:27:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQSKZB8rQUsfF2K@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/11/21 2:08 PM, Tejun Heo wrote:
> Hello,
>
> On Tue, Aug 10, 2021 at 11:06:03PM -0400, Waiman Long wrote:
>> For a partition root tree with parent and child partition roots, this
>> patch will now prohibit changing parent partition root back to member
>> as changes to "cpuset.cpus.partition" should not cause those child
>> partition roots to become invalid.
> So, the general rule is that a descendant should never be able to affect or
> restrict what an ancestor can do in terms of configuration. This is because
> descendant cgroups can be delegated and a system manager sitting at a higher
> level in the hierarchy may not have much control over what happens under
> delegated subtrees.
>
> Given that we're promoting the error state as the first class citizen in the
> interface anyway, wouldn't it be better to keep this in line too?

Disabling partition at the parent level does invalidate all the child 
partitions under it. So it must be done with care when we disable a 
partition.

How about we give some indication that a child partition exist when 
reading cpuset.cpus.partition and recommend double-checking it before 
disabling a partition? For example, we keep track of the number of cpus 
delegated to child partitions. Perhaps we can list that information on read.

With that information available, I have no objection to allow disabling 
a parent partition with child partitions under it.

Cheers,
Longman

