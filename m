Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2309644C6C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKJScB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 13:32:01 -0500
Received: from goliath.siemens.de ([192.35.17.28]:40995 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhKJScA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 13:32:00 -0500
X-Greylist: delayed 1446 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 13:31:59 EST
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AAI4ckg023350
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 19:04:39 +0100
Received: from [167.87.75.31] ([167.87.75.31])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AAI4ahw016947;
        Wed, 10 Nov 2021 19:04:36 +0100
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        "Moessbauer, Felix" <felix.moessbauer@siemens.com>,
        "longman@redhat.com" <longman@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "guro@fb.com" <guro@fb.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211110111357.17617-1-felix.moessbauer@siemens.com>
 <20211110135653.GD20566@blackbody.suse.cz>
 <AM9PR10MB4869C14EAE01B87C0037BF6A89939@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <20211110161020.GA20101@fuller.cnet>
 <c1e94031-a179-dc72-e5ee-3f8197bea492@siemens.com>
 <20211110175201.GA51149@blackbody.suse.cz>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44a28cc4-f68f-6e2c-1b0a-18b6570edc5f@siemens.com>
Date:   Wed, 10 Nov 2021 19:04:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211110175201.GA51149@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10.11.21 18:52, Michal Koutný wrote:
> On Wed, Nov 10, 2021 at 05:15:41PM +0100, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> Is there pthread_attr_setcgroup_np()?
> 
> If I'm not mistaken the 'p' in pthreads stands for POSIX and cgroups are
> Linux specific so you won't find that (unless you implement that
> yourself). ¯\_(ツ)_/¯
> 

I know what it stands for :). But I don't want to re-implement pthreads
just to have a single creation-time configurable injected. Neither would
developer of standard application, e.g. libvirt for the rt-kvm special
case while most of their use cases are fine with regular pthread APIs. I
think there is also a demand for a programming model that fits into
existing ones.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
