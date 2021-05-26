Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D44391CAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhEZQHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 12:07:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:9170 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233270AbhEZQHl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 12:07:41 -0400
IronPort-SDR: 6Km/DnQpeImm89JIBFKsklp0iTirXQnY8PHur881BOiStksQh7PosHpqo23fUty8enQ1yvujdC
 cAviMlbWu5xA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288082113"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="288082113"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 09:06:07 -0700
IronPort-SDR: iscuW0DqtorPR2O6rHQL/gUAjGSPdOaJKlPkbgsqbOyxVXgUA4EKiYmsUu+n5yDX17/gw6js32
 kZwmdl+LhPjA==
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="480106463"
Received: from sreddy2-mobl2.amr.corp.intel.com (HELO [10.255.229.59]) ([10.255.229.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 09:06:04 -0700
Subject: Re: x86/fpu/xsave: protection key test failures
To:     Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, shuah@kernel.org, jroedel@suse.de,
        ubizjak@gmail.com, viro@zeniv.linux.org.uk, jpa@git.mail.kapsi.fi,
        fenghua.yu@intel.com, kan.liang@linux.intel.com,
        akpm@linux-foundation.org, rppt@kernel.org, Fan_Yang@sjtu.edu.cn,
        anshuman.khandual@arm.com, b.thiel@posteo.de, jgross@suse.com,
        keescook@chromium.org, seanjc@google.com, mh@glandium.org,
        sashal@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        0x7f454c46@gmail.com, jhubbard@nvidia.com, sandipan@linux.ibm.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        suxingxing@loongson.cn, harish@linux.ibm.com,
        rong.a.chen@intel.com, linuxram@us.ibm.com, bauerman@linux.ibm.com,
        dave.kleikamp@oracle.com
References: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
 <7a407363-e074-aa84-3ca1-909b497122aa@intel.com>
 <a4f6b80d-8546-09dc-7435-25b3d890aace@amd.com>
 <e0dbd490-0209-9f74-36b7-c55992060b44@intel.com>
 <ab564da6-1029-1dab-d54e-a266a623974f@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <f4205ac9-5988-3b03-6b6a-b877335d19c9@intel.com>
Date:   Wed, 26 May 2021 09:06:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ab564da6-1029-1dab-d54e-a266a623974f@amd.com>
Content-Type: multipart/mixed;
 boundary="------------8E16EEEE763628152A53C51B"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------8E16EEEE763628152A53C51B
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

On 5/26/21 8:25 AM, Babu Moger wrote:
> On 5/25/21 7:20 PM, Dave Hansen wrote:
>> On 5/25/21 5:03 PM, Babu Moger wrote:
>>>> What values do PKRU and the shadow have when the test fails?  Is PKRU 0?
>>> It goes back to default value 0x55555554. The test is expecting it to be
>>> 0. Printed them below.
>>>
>>> test_ptrace_of_child()::1346, pkey_reg: 0x0000000055555554 shadow:
>>> 0000000000000000
>>> protection_keys_64: pkey-helpers.h:127: _read_pkey_reg: Assertion
>>> `pkey_reg == shadow_pkey_reg' failed.
>> That's backwards (shadow vs pkru) from what I was expecting.
>>
>> Can you turn on all the debuging?
>>
>> Just compile with -DDEBUG_LEVEL=5
> 
> Copied the logs at https://pastebin.com/gtQiHg8Q

Well, it's a bit backwards from what I'm expecting.  The PKRU=0 value
*WAS* legitimate because all of the pkeys got allocated and their
disable bits cleared.

I think Andy was close when he was blaming:

> static inline void write_pkru(u32 pkru)
> {
...
>         pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
...
>         if (pk)
>                 pk->pkru = pkru;
>         __write_pkru(pkru);
> }

But that can't be it because PKRU ended up with 0x55555554.  Something
must have been writing 'init_pkru_value'.

switch_fpu_finish() does that:

> static inline void switch_fpu_finish(struct fpu *new_fpu)
> {
>         u32 pkru_val = init_pkru_value;
...
>         if (current->mm) {
>                 pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
>                 if (pk)
>                         pkru_val = pk->pkru;
>         }
>         __write_pkru(pkru_val);
...
> }

If 'new_fpu' had XSTATE_BV[PKRU]=0 then we'd have pk=NULL and 'pkru_val'
would still have 'init_pkru_value'.  *Then*, we'd have a shadow=0x0 and
pkru=0x55555554.  It would also only trigger if the hardware has an init
tracker that fires when wrpkru(0).  Intel doesn't do that.  AMD must.

Anyway, I need to think about this a bit more.  But, an entirely
guaranteed to be 100% untested patch is attached.  I'm *NOT* confident
this is the right fix.

I don't have much AMD hardware laying around, so testing would be
appreciated.

--------------8E16EEEE763628152A53C51B
Content-Type: text/x-patch; charset=UTF-8;
 name="pkrusig.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pkrusig.patch"

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/f=
pu/internal.h
index 8d33ad8..21402eb 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -582,6 +582,8 @@ static inline void switch_fpu_finish(struct fpu *new_=
fpu)
 		pk =3D get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
 		if (pk)
 			pkru_val =3D pk->pkru;
+		else
+			pkru_val =3D 0x0;
 	}
 	__write_pkru(pkru_val);
=20

--------------8E16EEEE763628152A53C51B--
