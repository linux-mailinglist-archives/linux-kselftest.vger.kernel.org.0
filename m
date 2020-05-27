Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED71E33FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 02:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgE0ARC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 20:17:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45471 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgE0ARC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 20:17:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Wrx71vKpz9sSF;
        Wed, 27 May 2020 10:16:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590538620;
        bh=4XXmvXXfgbRN/jQoHPVi4ASoxTVhtQ8D1zRlN09CNaY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Hsk6C4529uGHiB6Qxtg7/t3N2n3844F+cEuC8SeuUCCZKR7ee0Sar9o4zhzuh7JYj
         NKqNMr0uteOA0OqstxVzUr0bzzstJGvfe6jATVRozDO/Utf/mGj4yBmjvd1vql6G68
         v8yTuY6c0dOV6PSfbarX8eUGFhcE4L/CHpVuCJLaM7qmr/EtiMBUmfWzftNw/DQTlt
         k9qfU1sNhvDq9q2MVI3qXDTnbOiI9KJNkE7Wgi9AEKU71Enz1Zf6O6e3lMcPB6hUzy
         4dVFoN1L+SX5BKrAwP7SyR6EMPRB/HKCd7P8rvC/qBv7AhK6fJbGL/7w/gor91XbWz
         brZ2CiCNtw6/w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        fweimer@redhat.com, ruscur@russell.cc
Subject: Re: [PATCH] selftests: powerpc: Add test for execute-disabled pkeys
In-Reply-To: <6b73bf3f-0d10-6e8c-acd9-27de53573dec@linux.ibm.com>
References: <20200508162332.65316-1-sandipan@linux.ibm.com> <87367mg9h4.fsf@mpe.ellerman.id.au> <6b73bf3f-0d10-6e8c-acd9-27de53573dec@linux.ibm.com>
Date:   Wed, 27 May 2020 10:17:22 +1000
Message-ID: <87tv02dyel.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sandipan Das <sandipan@linux.ibm.com> writes:
> Hi Michael,
>
> On 26/05/20 6:05 pm, Michael Ellerman wrote:
>> [...]
>>> +
>>> +/* Override definitions as they might be inconsistent */
>>> +#undef PKEY_DISABLE_ACCESS
>>> +#define PKEY_DISABLE_ACCESS	0x3
>> 
>> Why would they be inconsistent?
>> 
>
> The definition in sys/mman.h still uses the value specific to
> Intel's implementation i.e. 1, when this should have been 3
> for powerpc. I have seen this on Ubuntu 18.04 and 20.04.

Hmm OK, that's a bug but oh well nothing we can do about it.
 
>> I think a reasonable solution is to use the absence of SEGV_PKUERR to
>> basically turn the whole test into a nop at build time, eg:
...
>
> Or can I use this from the pkey tests under selftests/vm?
>
> static inline u32 *siginfo_get_pkey_ptr(siginfo_t *si)
> {
> #ifdef si_pkey
> 	return &si->si_pkey;
> #else
> 	return (u32 *)(((u8 *)si) + si_pkey_offset);
> #endif
> }
>
> Where si_pkey_offset is 0x20 for powerpc.

Yeah that's fine if it works. Please send a v2 with that change.

cheers
