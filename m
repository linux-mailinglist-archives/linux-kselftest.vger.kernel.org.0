Return-Path: <linux-kselftest+bounces-219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD47EE1EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7CE1C209CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF222F841;
	Thu, 16 Nov 2023 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2JsYxSx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B6EC1
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700142741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IhNoZXTI+fdHl/DEzf2VZ3Tt0lwyDlfYgNAl7FX9nY=;
	b=M2JsYxSx5giPpRtkQLZYVbbDvO0ohyS5NNLUtaWZIaMKBaTq5sV0DcGPuL7ux1uyqPwvFz
	jrqXZzl73ljeky5QAPgak1cmNtSmikE2F+F1/QsZQDHRjJHg5RIkLjiauGlq31ROUsbt76
	Jm/msgXaILkzLLqgeGgoY+WOIFJKCNU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-egn1kmvCMrO-2Ca73ZWYiQ-1; Thu, 16 Nov 2023 08:52:20 -0500
X-MC-Unique: egn1kmvCMrO-2Ca73ZWYiQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77bc720da87so83930585a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 05:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700142739; x=1700747539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IhNoZXTI+fdHl/DEzf2VZ3Tt0lwyDlfYgNAl7FX9nY=;
        b=nLhxD6sJExjuro1UGxeom6os5icEi9ZiL63Ean2MzZFUvOSc/QtslJU9j957ixc+w1
         P+SQwOnCPaKhW6poDTaK+F9sI448pEhxXnHoX3SsSGPLES7rxV/mCxHK0ULeIQDW47cP
         K3MqeMVS2yeVng+H16d7BOf8zQh0a8HJyGtAub7DjJ/dU3nycACMwIgzYDrCHx1OqeDT
         UJZsyKC9DvsQKPPF32rbUsD0Kv/YYT2KGVhNjMPUG+7CT5D7uM12IgzU3BFK4HT/Fu4S
         5Ery/DmAzmmtOgZdweVl2OoZtC0DRu3Ztns/ybB3iIFPnX54TBPqJxnNlELOC3EYQHXU
         j8hA==
X-Gm-Message-State: AOJu0Yyb5hQJxRvhQkIWnHNqPzfjDxz8RVAKPEBjaoEszwacRRXLKRaj
	dxv8TgqybuDSDtELwGqKnoUDScuCDS5Le2qgsLnPR8uoibvgxBw6Sp/iJlg0fph0bjnFjYJTO12
	1MWuxrtAwPOYaJ2eBOBTH5M1WYSn/rVIG1dqWvB8=
X-Received: by 2002:a05:620a:458a:b0:767:8373:a890 with SMTP id bp10-20020a05620a458a00b007678373a890mr11230864qkb.45.1700142738895;
        Thu, 16 Nov 2023 05:52:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXaWFlxQm4PRVVx+8Fj6YF5JxVcSJZQ1LW22bPzS1N8WPExtfrQ7x7wEOyBfxYn5nY0LpOUw==
X-Received: by 2002:a05:620a:458a:b0:767:8373:a890 with SMTP id bp10-20020a05620a458a00b007678373a890mr11230835qkb.45.1700142738580;
        Thu, 16 Nov 2023 05:52:18 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id qz6-20020a05620a8c0600b00774292e636dsm4282695qkn.63.2023.11.16.05.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 05:52:17 -0800 (PST)
Message-ID: <6d705be6-bcce-453a-a0e0-305b3212d4ff@redhat.com>
Date: Thu, 16 Nov 2023 15:52:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
 Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong"
 <djwong@kernel.org>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>,
 CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <20231115-charcoal-sloth-of-wizardry-5a75fa@nitro>
 <13fe4866-0522-4690-a060-160fdab9f54b@redhat.com>
 <195ed085-9f66-4951-bb5b-2d8560f380eb@sirena.org.uk>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <195ed085-9f66-4951-bb5b-2d8560f380eb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/23 15:26, Mark Brown wrote:
> On Thu, Nov 16, 2023 at 02:14:24PM +0200, Nikolai Kondrashov wrote:
> 
>> Yes, that would be better indeed. However, checkpatch.pl doesn't process
>> cover letters, and so we would have no automated way to advertise and nudge
>> people towards testing.
> 
> Back when I used to run checkpatch it seemed to cope, it obviously
> wouldn't find much to look at in there but you could feed it an entire
> series with cover letter and the cover letter wouldn't cause any extra
> issues.

Ah, good to know, thank you. The question now is whether we can expect, or 
require, submitters to run checkpatch.pl on the complete patchset, cover 
letter included, *before* sending it.

>> P.S. Git forges do that for you by nature of actually running the tests
>> themselves, automatically. *Ducks*
> 
> The ability of forges to run tests is not hugely relevant to large
> portions of the kernel, for drivers you're wanting the tests to run on
> the relevant hardware and even core changes will often need hardware
> that exercises the relevant features to run.  In these areas you're more
> just looking for someone to say that they've done relevant testing but
> there's not a substantial difference between say a comment on a pull
> request or a followup email.

Agreed.

Still, there *are* largely hardware-independent (and thus maybe more 
impactful) parts of the kernel too.

Plus, you know yourself there's a bunch of companies willing (if not outright 
clamoring) to contribute their machine time for testing, provided some good 
will and authentication on the part of the contributors. And git forges 
provide good support for the latter. So perhaps *some* special hardware 
*could* be arranged there too, making it more useful.

Nick


