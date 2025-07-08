Return-Path: <linux-kselftest+bounces-36747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D75AFC71D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 11:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CE53B415F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF8231842;
	Tue,  8 Jul 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="anLQ5mlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07722F75B
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967134; cv=none; b=dzYXYWggnsh20jwZpBvXoFOL1t8ZP6J9KscJuW5J71g66KKQK1EnbnIrj16N1wp4l1JPDoQHIqi4AULexuMLQEw5FADzOs7MtRF7tYW6AtxBugmMhsEXRSk+9QX42aIWEW6WP0a+TGjujsJY1FkK5TfAMzqpkaEnFWIyn1iX1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967134; c=relaxed/simple;
	bh=VpT4faI2QrhfOSkR5ZLdixn7ZKU0ZQTFE8Y+uInHVCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/UYqZD7YfpTZe+JsAKOO3DiRVsQRERiOI3NQzKR5AXjf/HXgXdZLtp3vMD/IQQ9KgjMylTDgjlq4Bgg6L7E5zux40bpmGdS3BF51t59PHNdBk+tAfHRy1Rs1bQXWO0jMBJpK5o0ST3iMHNMwsqKm6OuTBO/oThueAxzunv/IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=anLQ5mlv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-454ac069223so25525805e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751967130; x=1752571930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGJceIW5govnMWwv0NuUJQBgYLDuIDSURIFJwwyGYJU=;
        b=anLQ5mlvg1wN9HgBeWDld6tp9HA1BuNaafuz+c0vrSdEqkiFR+y5+t2Zvlv+YVqhMC
         rjM+vke+CqAbB5a6xNofYdPHWKBbD761gtv0oJSHSFKpuYpGAaPT57r5aX0eUUmv3aF6
         a7jdP3I86BEOXHfJ1E0gfa6yoVl9UfyDg2ZXMVoJEmsDMaKcFA7i/Mq6y3UWqeiKg/4k
         zN2/6V6hFsMcOE58rNZ90YAJEpM06noblm9zwomhYDWRqIz9TXrwKYBzZmN77Ev5SUlX
         AYigs259NdIRjzZyMy0CmT03wKiBfUubQtEvyNMhkVD4I0GdE0YEA+NSQGpXY7EC6hPK
         zM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751967130; x=1752571930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGJceIW5govnMWwv0NuUJQBgYLDuIDSURIFJwwyGYJU=;
        b=L8VNNwX1ttqHh5Ddqc1F/31DCqQb9cSUFC/XtxG3O2VRlqhscBrF34kBNaUh2mzpfM
         g6qW0KWab1lu+z2h7xGX+B+AnfZxJhHG3eGMUR1dNbU2bRBWGYlnNzdYkjpT0hls0inQ
         MtnzYQmvx7cX8McvR+bat8aOr7aFfNRv6AwlmgooTOpZACSmtE5SI6guxgb//hLsnPEi
         56oWrzlY5g8PEOB2knH5A5HWmzNebQPO0HUfezkUntsPETpmsiPrHYuhlnh84IaI3VW1
         uhO9vquxWsqW5Le2bQl/bJeVO0FGGZ1VavkiBL646ck8P0/LjH/F67X6zxdtfY5MkB/C
         lMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdILwumz6AC0r3SbMO8BTJyGEotkp2TTQudPC6yVxPGEJ7FkSTLTFjRqdSJ9EMOaHSADE8YJ4Nn0E2PlzG27Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYPruzvnlVQWXZ76GvAoTc0nOKHRtSuxIt2Hg40gOe6zf5pVK
	4uE5V2/yYt//Rdmq1s+Vw3h6Oih3PL4rtSZo1VqAmMaAV0VKIFzbbX20wwVY1BhqKPs=
X-Gm-Gg: ASbGnct2GUrUpu7JfwBw62LIkNzvnqHHgY7UC99/hM73sKR6SghBmW7M0k/ycrF/Tjm
	C3YNdY9UWtuOmODDSZm7RxrAkL4N/emConvJdASk/UGn/qcp2DiRT0sKKfVIFSW5cze1muPUEYp
	QjpBKMH8BpXkScub0QxKWWTPtxMmzRDPCdgjs0Idc3pHY4+foLcUyxSj9kpO9nXCtpSBxURPAl6
	ZkVwTuMFVajw31HwA32+fTQpOwHFXjchC/SSn8oSEEbhWrHepfXg9WkVvsjG73VDv0ANWbQIWvX
	uJuQS5yO4KDxRY0VbrLvgtgqiYIZlXSxFC27+i7NOY8OVp82JU+CnZsIDKhQpeXLNg==
X-Google-Smtp-Source: AGHT+IGpfK2RCAo/edKvTlUC+d9AURbdyD484XFqxor+Ht3SNk4f42ge+bO29Nor8b5E8oXUHRj2Iw==
X-Received: by 2002:a05:6000:240c:b0:3a5:281b:9fac with SMTP id ffacd0b85a97d-3b5de11ea28mr1823078f8f.17.1751967130016;
        Tue, 08 Jul 2025 02:32:10 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225977dsm12455087f8f.73.2025.07.08.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:32:09 -0700 (PDT)
Message-ID: <9c8b2847-5017-45b8-bbc2-0ba96cc42961@suse.com>
Date: Tue, 8 Jul 2025 11:32:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] module: make structure definitions always visible
To: Daniel Gomez <da.gomez@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
 <a9eade27-9b77-431f-b7c8-24c3fb891673@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <a9eade27-9b77-431f-b7c8-24c3fb891673@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/7/25 9:11 PM, Daniel Gomez wrote:
> On 12/06/2025 16.53, Thomas WeiÃschuh wrote:
>> To write code that works with both CONFIG_MODULES=y and CONFIG_MODULES=n
>> it is convenient to use "if (IS_ENABLED(CONFIG_MODULES))" over raw #ifdef.
>> The code will still fully typechecked but the unreachable parts are
>> discarded by the compiler. This prevents accidental breakage when a certain
>> kconfig combination was not specifically tested by the developer.
>> This pattern is already supported to some extend by module.h defining
>> empty stub functions if CONFIG_MODULES=n.
>> However some users of module.h work on the structured defined by module.h.
>>
>> Therefore these structure definitions need to be visible, too.
> 
> We are missing here which structures are needed. + we are making more things
> visible than what we actually need.
> 
>>
>> Many structure members are still gated by specific configuration settings.
>> The assumption for those is that the code using them will be gated behind
>> the same configuration setting anyways.
> 
> I think code and kconfig need to reflect the actual dependencies. For example,
> if CONFIG_LIVEPATCH depends on CONFIG_MODULES, we need to specify that in
> Kconfig with depends on, as well as keep the code gated by these 2 configs with
> ifdef/IS_ENABLED.
> 
>>
>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>> ---
>>  include/linux/module.h | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 52f7b0487a2733c56e2531a434887e56e1bf45b2..7f783e71636542b99db3dd869a9387d14992df45 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -302,17 +302,6 @@ static typeof(name) __mod_device_table__##type##__##name		\
>>  
>>  struct notifier_block;
>>  
>> -#ifdef CONFIG_MODULES
>> -
>> -extern int modules_disabled; /* for sysctl */
>> -/* Get/put a kernel symbol (calls must be symmetric) */
>> -void *__symbol_get(const char *symbol);
>> -void *__symbol_get_gpl(const char *symbol);
>> -#define symbol_get(x)	({ \
>> -	static const char __notrim[] \
>> -		__used __section(".no_trim_symbol") = __stringify(x); \
>> -	(typeof(&x))(__symbol_get(__stringify(x))); })
>> -
>>  enum module_state {
>>  	MODULE_STATE_LIVE,	/* Normal state. */
>>  	MODULE_STATE_COMING,	/* Full formed, running module_init. */
>> @@ -598,6 +587,18 @@ struct module {
>>  	struct _ddebug_info dyndbg_info;
>>  #endif
>>  } ____cacheline_aligned __randomize_layout;
>> +
>> +#ifdef CONFIG_MODULES
>> +
>> +extern int modules_disabled; /* for sysctl */
>> +/* Get/put a kernel symbol (calls must be symmetric) */
>> +void *__symbol_get(const char *symbol);
>> +void *__symbol_get_gpl(const char *symbol);
>> +#define symbol_get(x)	({ \
>> +	static const char __notrim[] \
>> +		__used __section(".no_trim_symbol") = __stringify(x); \
>> +	(typeof(&x))(__symbol_get(__stringify(x))); })
>> +
> 
> The patch exposes data structures that are not needed. + breaks the
> config dependencies.
> 
> For example, before this patch:
> 
> #ifdef CONFIG_MODULES
> 
> {...}
> 
> struct mod_tree_node {
> 
> {...}
> 
> struct module_memory {
> 	void *base;
> 	bool is_rox;
> 	unsigned int size;
> 
> #ifdef CONFIG_MODULES_TREE_LOOKUP
> 	struct mod_tree_node mtn;
> #endif
> };
> 
> {...}
> #endif /* CONFIG_MODULES */
> 
> After the patch, mod_tree_node is not needed externally. And the mtn field
> in module_memory is exposed only under MODULES_TREE_LOOKUP and not MODULES
> + MODULES_TREE_LOOKUP.
> 
> I general, I see the issues I mentioned with LIVEPATCH, mod_tree_node, macros,
> and LOOKUP.

I think the idea is that having unnecessary structures in header files
isn't particularly harmful, as they won't affect the resulting binary.
On the other hand, they can help with type checking of conditional code
as shown by patch #3.

This is different compared to "extern int modules_disabled;" and
"void *__symbol_get(const char *symbol);" which the patch correctly
still protects by '#ifdef CONFIG_MODULES'. Not hiding them could result
in successful compilation but an error only at link time.

-- 
Thanks,
Petr

