Return-Path: <linux-kselftest+bounces-44100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA729C0E4E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 15:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0D819A39DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B230B511;
	Mon, 27 Oct 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eSQyY/o+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HxBj57Va";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eSQyY/o+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HxBj57Va"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDDB30B526
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574095; cv=none; b=XZ9WplEujXLEaxQCBomNypaRp0hgvWwKAH00DHp8zmin6+vkTFobhiVJJgthtPRRiEU/07cNXIUAjzpjwyOzZisiXFWcTOndGJ6EM3wlZ55tRjfqvYyYENm+plfjiWVjfq+43Ii4f73tum7lnCUUROuyM4xcYlIXI+0luOY1YXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574095; c=relaxed/simple;
	bh=zHzJFZSC/XVvaaKSpNtTtrYvmzQLyySdcDBERutAuvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cS1QYlyFi9l+rFbDU+9H4JPy9TVnYxTgFw/l8rAczN9HHoR1ca6H26DXM2A+WaoGQA/7oOpD0Hmw46MN396LRrGkBShwTsyP3Y8yu4TEfrjgZ+P3CqrRn2xYz3glAT6+1e6s06p68WP1gOOGq9zFekUabgPUHTCaqIiXuYgIsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eSQyY/o+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HxBj57Va; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eSQyY/o+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HxBj57Va; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEF7821A64;
	Mon, 27 Oct 2025 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761574091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yNDjf2ZkDcwefxbfbTlFfYFP26XA7S/G/BvwaqnvCqI=;
	b=eSQyY/o+rh5mjPNza8tf5wvXXvFTAHFZ1tIxk6b6/A94hYeE6WXn7QUBjfw6SfYL43pz1I
	LPBth3S8oOG96RZLQREXma5XiZpfYdXuI8NOjJzvkPWihYfKz8TtYU1icl9iyBa9i/fBB7
	uzDoQaekE/lim/gISn2EydfFybLrYIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761574091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yNDjf2ZkDcwefxbfbTlFfYFP26XA7S/G/BvwaqnvCqI=;
	b=HxBj57VaFKgikDOWzpvAJS4F0WWYugR3TfeewtqV2ZQEDYebjVc60HUazYhD1qfFBHnvrB
	aGJa1oMLhaShGuBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761574091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yNDjf2ZkDcwefxbfbTlFfYFP26XA7S/G/BvwaqnvCqI=;
	b=eSQyY/o+rh5mjPNza8tf5wvXXvFTAHFZ1tIxk6b6/A94hYeE6WXn7QUBjfw6SfYL43pz1I
	LPBth3S8oOG96RZLQREXma5XiZpfYdXuI8NOjJzvkPWihYfKz8TtYU1icl9iyBa9i/fBB7
	uzDoQaekE/lim/gISn2EydfFybLrYIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761574091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yNDjf2ZkDcwefxbfbTlFfYFP26XA7S/G/BvwaqnvCqI=;
	b=HxBj57VaFKgikDOWzpvAJS4F0WWYugR3TfeewtqV2ZQEDYebjVc60HUazYhD1qfFBHnvrB
	aGJa1oMLhaShGuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54B9913A9A;
	Mon, 27 Oct 2025 14:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NtFNE8t8/2i+eAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Oct 2025 14:08:11 +0000
Message-ID: <69215332-2bc7-464a-9d6e-4e9d8ec66511@suse.de>
Date: Mon, 27 Oct 2025 15:08:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20251027: backlight.c:59:39: error: implicit declaration of
 function 'of_find_node_by_name'; did you mean 'bus_find_device_by_name'?
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, danielt@kernel.org,
 Lee Jones <lee@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Ben Copeland <benjamin.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYs8fn5URQx2+s2oNxdUgZkSrdLC0P1tNBW_n-6BaBkK2Q@mail.gmail.com>
 <CA+G9fYumAD1_G4UG2LDAPD3fRxN+WQnrm8tPx6pL8qF6wSOUrw@mail.gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <CA+G9fYumAD1_G4UG2LDAPD3fRxN+WQnrm8tPx6pL8qF6wSOUrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:url,linaro.org:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Hi,

fix is at 
https://lore.kernel.org/dri-devel/20251027140646.227025-1-tzimmermann@suse.de/

Best regards
Thomas

Am 27.10.25 um 09:38 schrieb Naresh Kamboju:
> On Mon, 27 Oct 2025 at 13:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>> The following powerpc ppc6xx_defconfig build regressions noticed on the
>> Linux next-20251027 tag with gcc-14 and gcc-8.
>>
>> * powerpc, build
>>    - gcc-14-ppc6xx_defconfig
>>    - gcc-8-ppc6xx_defconfig
>>
>> First seen on next-20251027
>> Good: next-20251024
>> Bad: next-20251027
>>
>> Regression Analysis:
>> - New regression? yes
>> - Reproducibility? yes
>>
>> Build regression: next-20251027: backlight.c:59:39: error: implicit
>> declaration of function 'of_find_node_by_name'; did you mean
>> 'bus_find_device_by_name'?
>> Build regression: next-20251027: include/linux/math.h:167:43: error:
>> first argument to '__builtin_choose_expr' not a constant
>> Build regression: next-20251027: via-pmu-backlight.c:22:20: error:
>> 'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
>> Build regression: next-20251027: minmax.h:71:17: error: first argument
>> to '__builtin_choose_expr' not a constant
>> Build regression: next-20251027: compiler.h:168:17: error:
>> '__UNIQUE_ID_x__286' undeclared (first use in this function); did you
>> mean '__UNIQUE_ID_y__287'?
> Anders bisected this down to,
> # first bad commit:
>     [243ce64b2b371cdf2cbc39c9422cb3047cab6de7]
>     backlight: Do not include <linux/fb.h> in header file
>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> ## Build error
>> arch/powerpc/platforms/powermac/backlight.c: In function
>> 'pmac_has_backlight_type':
>> arch/powerpc/platforms/powermac/backlight.c:59:39: error: implicit
>> declaration of function 'of_find_node_by_name'; did you mean
>> 'bus_find_device_by_name'? [-Wimplicit-function-declaration]
>>     59 |         struct device_node* bk_node =
>> of_find_node_by_name(NULL, "backlight");
>>        |                                       ^~~~~~~~~~~~~~~~~~~~
>>        |                                       bus_find_device_by_name
>> arch/powerpc/platforms/powermac/backlight.c:59:39: error:
>> initialization of 'struct device_node *' from 'int' makes pointer from
>> integer without a cast [-Wint-conversion]
>> arch/powerpc/platforms/powermac/backlight.c:60:17: error: implicit
>> declaration of function 'of_property_match_string'
>> [-Wimplicit-function-declaration]
>>     60 |         int i = of_property_match_string(bk_node,
>> "backlight-control", type);
>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/platforms/powermac/backlight.c:62:9: error: implicit
>> declaration of function 'of_node_put'
>> [-Wimplicit-function-declaration]
>>     62 |         of_node_put(bk_node);
>>        |         ^~~~~~~~~~~
>> drivers/macintosh/via-pmu-backlight.c:22:20: error:
>> 'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
>>     22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
>>        |                    ^~~~~~~~~~~~~~~~~~~
>> In file included from <command-line>:
>> drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_curve_lookup':
>> include/linux/compiler.h:168:17: error: '__UNIQUE_ID_x__286'
>> undeclared (first use in this function); did you mean
>> '__UNIQUE_ID_y__287'?
>>    168 |         __PASTE(__UNIQUE_ID_,                                   \
>>        |                 ^~~~~~~~~~~~
>> drivers/macintosh/via-pmu-backlight.c:45:23: note: in expansion of macro 'max'
>>     45 |                 max = max((int)bl_curve[i], max);
>>        |                       ^~~
>> include/linux/minmax.h:71:17: error: first argument to
>> '__builtin_choose_expr' not a constant
>>     71 |         (typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL,
>> 1L)))(ux) >= 0)
>>        |                 ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:577:23: note: in definition of macro
>> '__compiletime_assert'
>>    577 |                 if (!(condition))
>>           \
>>        |                       ^~~~~~~~~
>> drivers/macintosh/via-pmu-backlight.c:45:23: note: in expansion of macro 'max'
>>     45 |                 max = max((int)bl_curve[i], max);
>>        |                       ^~~
>> include/linux/minmax.h:71:17: error: first argument to
>> '__builtin_choose_expr' not a constant
>>     71 |         (typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL,
>> 1L)))(ux) >= 0)
>>        |                 ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:577:23: note: in definition of macro
>> '__compiletime_assert'
>>    577 |                 if (!(condition))
>>           \
>>        |                       ^~~~~~~~~
>> include/linux/minmax.h:112:25: note: in expansion of macro '__careful_cmp'
>>    112 | #define max(x, y)       __careful_cmp(max, x, y)
>>        |                         ^~~~~~~~~~~~~
>> drivers/macintosh/via-pmu-backlight.c:45:23: note: in expansion of macro 'max'
>>     45 |                 max = max((int)bl_curve[i], max);
>>        |                       ^~~
>> In file included from include/linux/kernel.h:27,
>>                   from arch/powerpc/include/asm/page.h:11,
>>                   from arch/powerpc/include/asm/thread_info.h:13,
>>                   from include/linux/thread_info.h:60,
>>                   from arch/powerpc/include/asm/ptrace.h:342,
>>                   from drivers/macintosh/via-pmu-backlight.c:11:
>> include/linux/math.h:162:17: error: first argument to
>> '__builtin_choose_expr' not a constant
>>    162 |                 __builtin_choose_expr(
>>           \
>>        |                 ^~~~~~~~~~~~~~~~~~~~~
>>
>> drivers/macintosh/via-pmu-backlight.c: In function
>> 'pmu_backlight_get_level_brightness':
>> drivers/macintosh/via-pmu-backlight.c:63:38: error: 'FB_BACKLIGHT_MAX'
>> undeclared (first use in this function); did you mean 'BACKLIGHT_RAW'?
>>     63 |         pmulevel = bl_curve[level] * FB_BACKLIGHT_MAX / MAX_PMU_LEVEL;
>>        |                                      ^~~~~~~~~~~~~~~~
>>        |                                      BACKLIGHT_RAW
>> drivers/macintosh/via-pmu-backlight.c:58:51: warning: parameter
>> 'level' set but not used [-Wunused-but-set-parameter]
>>     58 | static int pmu_backlight_get_level_brightness(int level)
>>        |                                               ~~~~^~~~~
>> drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_init':
>> drivers/macintosh/via-pmu-backlight.c:144:17: error: implicit
>> declaration of function 'of_machine_is_compatible'
>> [-Wimplicit-function-declaration]
>>    144 |                 of_machine_is_compatible("AAPL,3400/2400") ||
>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/macintosh/via-pmu-backlight.c: At top level:
>> drivers/macintosh/via-pmu-backlight.c:22:11: warning: 'bl_curve'
>> defined but not used [-Wunused-variable]
>>     22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
>>        |           ^~~~~~~~
>> make[5]: *** [scripts/Makefile.build:287:
>> drivers/macintosh/via-pmu-backlight.o] Error 1
>> make[5]: Target 'drivers/macintosh/' not remade because of errors.
>>
>>
>> ## Source
>> * Kernel version: 6.18.0-rc2-next-20251027
>> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
>> * Git describe: next-20251027
>> * Git commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
>> * Architectures: powerpc
>> * Toolchains: gcc-14
>> * Kconfigs: defconfig
>>
>> ## Build
>> * Test log: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrlb77LGOQQSoC8FHCiIEAZK/build.log
>> * Test details:
>> https://regressions.linaro.org/lkft/linux-next-master/next-20251027/build/gcc-14-ppc6xx_defconfig/
>> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34dKrlb77LGOQQSoC8FHCiIEAZK
>> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrlb77LGOQQSoC8FHCiIEAZK/
>> * Kernel config:
>> https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrlb77LGOQQSoC8FHCiIEAZK/config
>>
>> --
>> Linaro LKFT
> - Naresh

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



