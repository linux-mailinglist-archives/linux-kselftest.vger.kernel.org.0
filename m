Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD838DB73
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 May 2021 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhEWOop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 May 2021 10:44:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:13160 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhEWOoo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 May 2021 10:44:44 -0400
IronPort-SDR: jdm/FwnGmhZLDcP85XdDkYMrNeuO5BGf7FwDxU63MQVUANEdgn1b+ai82sT0zRCPJDw7fOUc1j
 L8BphR2hkIHw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="265682215"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265682215"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 07:43:17 -0700
IronPort-SDR: bfbTjY++YiuW1i/hCo9WvS45EoK6nkaGMtHPqopj5Sn8M4xVAdmJRzzA8WZN2lrgwLabxiTnlf
 q4zxKzbNOtFg==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="613834401"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.135.25]) ([10.252.135.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 07:43:17 -0700
Subject: Re: [PATCH v7 0/7] Fork brute force attack mitigation
To:     John Wood <john.wood@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20210521172414.69456-1-john.wood@gmx.com>
 <19903478-52e0-3829-0515-3e17669108f7@linux.intel.com>
 <20210523073124.GA3762@ubuntu>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <3d4ddd55-4f42-3ef7-dd68-a9f2bc33ba4b@linux.intel.com>
Date:   Sun, 23 May 2021 07:43:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210523073124.GA3762@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/23/2021 12:31 AM, John Wood wrote:
> Hi,
>
> On Fri, May 21, 2021 at 11:02:14AM -0700, Andi Kleen wrote:
>>> Moreover, I think this solves another problem pointed out by Andi Kleen
>>> during the v5 review [2] related to the possibility that a supervisor
>>> respawns processes killed by the Brute LSM. He suggested adding some way so
>>> a supervisor can know that a process has been killed by Brute and then
>>> decide to respawn or not. So, now, the supervisor can read the brute xattr
>>> of one executable and know if it is blocked by Brute and why (using the
>>> statistical data).
>> It looks better now, Thank.
>>
>> One potential problem is that the supervisor might see the executable
>> directly, but run it through some wrapper. In fact I suspect that will be
>> fairly common with complex daemons. So it couldn't directly look at the
>> xattr. Might be useful to also pass this information through the wait*
>> chain, so that the supervisor can directly collect it. That would need some
>> extension to these system calls.
>>
> Could something like this help? (not tested)

This works even when someone further down the chain died? Assuming it 
does, for SIGCHLD it seems reasonable.

I'm not fully sure how it will interact with cgroup release tracking 
though, that might need more research (my understanding is that modern 
supervisors often use cgroups)

-Andi


