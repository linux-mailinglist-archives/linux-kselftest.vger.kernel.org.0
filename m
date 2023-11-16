Return-Path: <linux-kselftest+bounces-211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5FA7EE083
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BEE280FAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F62FC26;
	Thu, 16 Nov 2023 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyJEXYrq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DB49C
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 04:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700136872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bNUOH0W+hzau0QOi98ae0r3jNAzrQ9c27bIiiL1MLQ=;
	b=eyJEXYrqlqD+kGn74kTIMOMVxi3Wf/PzONxepsDXzIteiRrEz0GJAq++9HfKW64WbeVt3m
	SADASCIJEaMayzgY9Erz7Jjsa8Ie1N2lbf76FIRmjAKJMZtIy+k+iku11nU0L4UFjt0LJE
	Ah4NlPBsZrAPYUOuEGUHQ7t0LPc2PMs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-8tQSgAD3Mnay7p9nm7i2yg-1; Thu, 16 Nov 2023 07:14:29 -0500
X-MC-Unique: 8tQSgAD3Mnay7p9nm7i2yg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-421ad4ca88dso8252091cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 04:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136869; x=1700741669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bNUOH0W+hzau0QOi98ae0r3jNAzrQ9c27bIiiL1MLQ=;
        b=h3tjDCQ2jtr+A7XdzKY455asCIYiRapoh27pQ/Rg7FH1lvFmIq71rNGlSiXXNzmrRC
         WZftpLmT2V494uCzzN6n63KS6AUnRxj6mXmBOgFTG9MTIFV845PWzqA+oKcRExyEjTMc
         FenPZj8WswhVzoKuML4qQrjybu6/gvUxuqCrjMqbMDpOW7Q2e+oW4VZd8nOcC0kF/6t5
         ig5y7eupueViaYNPzk4VdvJA1FfEeG+9wEmF3aeINdGeCzljFkL5QWDrA3XrEpsj2Mcf
         mYWMyJBSL91lyn6LEZngNo8Cu6w9hG2Ynw9S/8Q+m4rbf2GrGI6cz556iJZSpM4FWSwl
         aEIQ==
X-Gm-Message-State: AOJu0YyDaa2xMr//sh64DvWaCH68Id40Orpj/WfnC/huTtDghTgamO2O
	IcNi8y1Y55d9175o0uyr3RfVxTIieo/WqYF6beSvv5GdmQl0F4qqpD8LAziP15hctB8FyYroRe1
	40w8yZNCCRBZTyeKtYKwe1mojqX32
X-Received: by 2002:ac8:7f4c:0:b0:41c:dd22:e7bf with SMTP id g12-20020ac87f4c000000b0041cdd22e7bfmr10072042qtk.42.1700136868944;
        Thu, 16 Nov 2023 04:14:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPGczeFtCmKIQDf7fheNsirZABfTHQecH6L89Gj9lo6GuRXElt/m+iwntGdSDoB0dFD/x7OA==
X-Received: by 2002:ac8:7f4c:0:b0:41c:dd22:e7bf with SMTP id g12-20020ac87f4c000000b0041cdd22e7bfmr10072017qtk.42.1700136868716;
        Thu, 16 Nov 2023 04:14:28 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id g9-20020ac84dc9000000b0041cb787ff41sm4251329qtw.67.2023.11.16.04.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 04:14:28 -0800 (PST)
Message-ID: <13fe4866-0522-4690-a060-160fdab9f54b@redhat.com>
Date: Thu, 16 Nov 2023 14:14:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Content-Language: en-US
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
 Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "Darrick J . Wong" <djwong@kernel.org>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>,
 CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <20231115-charcoal-sloth-of-wizardry-5a75fa@nitro>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231115-charcoal-sloth-of-wizardry-5a75fa@nitro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/23 22:38, Konstantin Ryabitsev wrote:
> On Wed, Nov 15, 2023 at 07:43:49PM +0200, Nikolai Kondrashov wrote:
>> Introduce a new tag, 'Tested-with:', documented in the
>> Documentation/process/submitting-patches.rst file. The tag is expected
>> to reference the documented test suites, similarly to the 'V:' field,
>> and to certify that the submitter executed the test suite on the change,
>> and that it passed.
> 
> I'm not sure it should be a tag that stays all the way through git commit.
> How about making it a cover letter/first patch footer?
> 
> tested-with: <suite>

Yes, that would be better indeed. However, checkpatch.pl doesn't process cover 
letters, and so we would have no automated way to advertise and nudge people 
towards testing.

Nick

P.S. Git forges do that for you by nature of actually running the tests 
themselves, automatically. *Ducks*


