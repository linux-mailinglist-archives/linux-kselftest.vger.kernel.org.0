Return-Path: <linux-kselftest+bounces-4227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0F284C6B2
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 09:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27601F24E24
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE9E208AB;
	Wed,  7 Feb 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7fj4m5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8689210EC;
	Wed,  7 Feb 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296056; cv=none; b=PK6WcJtcz+c0MZnlm5cNpEA/yJxT2aN0wn/xTsJ6hrKm2awvC0tO6kWN5jlOkCsxIMXJqa4ukTm11/zXAIFmDtoK8rIX6hki31IP1dz7ye2u9se1ALX6DyUaMpKZR36Gpd996sRXZ1/zvJ/7dif8K98cLkmftUSTo8DJaZFliJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296056; c=relaxed/simple;
	bh=K1hT0Ff6c2qGsmsWFPtyZNip5/MybnCJTRlAvfyyUhA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S+HoduJGVflXcTZTnuHiAHKdwldoDSc1abojMbKRQ5jYj9g5e9gxhkdDEX8Yrt4GTu3IFxChqxeXqbwcm1ekxTwL6hRPZqb4tjy0CHiVPDpAUuxYwkvjYmR0rM48jfeKgu/VLgcKjbPxZOenH+D2UEOQE5KQul43bW9VeSzqaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7fj4m5S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3850ce741bso40849466b.3;
        Wed, 07 Feb 2024 00:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707296053; x=1707900853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQVAZ3rVeIQaP1TfF8JXnCRQN6+QXcLA8n86yEMCD98=;
        b=K7fj4m5SKCxTY1Z7R8AiGdBYmFT5fu1MUkIL78zyGqG4mgWNK4hMYCBu3yMUVS/n/n
         P7mUD40D+mi8ZafAtCc0vPAjTiwNzsaJXK368RDogeLJEL0k9Eq8VXYwn/J1GIdlLshf
         uaAQq/Xzzzf0yl/fJxzP5EUfbslqGu+bgSQnZYIJJHl37Lk/sE0u9HOs7e1F1kHuCqnY
         dTPg4xwlBFoQn46LDix5PzzjVIsd6s6yhWkFN9yJygqdIaIMxvwDC6koDDltqQBjKTEL
         ixctpc+ZVqqu8AG4tAyKMf2v40k1JxU/3UWStYubAYAtdtOKaCxB0FtBqdd+e/CmuxUO
         tb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296053; x=1707900853;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQVAZ3rVeIQaP1TfF8JXnCRQN6+QXcLA8n86yEMCD98=;
        b=tzuH4Y83hObGRrVpPoyQKOonlVZ3npGAc0GDA6hBSQvd9R82ZDJEpgyc+B0IZvtU6p
         EQofitL1kHbJtB71W17ScZDmq6wsVyMQxdSk3PmBdELQU6e5YxsP0F94JrS7NgMo1w/m
         aQKdVmx7pExZHgk6SuzlrtWCrSfa4c71pCe3t/566U26AIsBCP4kVZDZc8QTDLV+YYAf
         jh5nomwJges/OQwY35bJbzJlbhTE8QVvtn05J5YIKX/91d/tOqmLlPKeZxDlELoG0N3M
         t+X6p48xcxP7V4lcRf3UoBzZ9e75idZLrrHk+RJzoRWOSu2KUK/STvEIGbkM/Eqrs/xN
         TvrQ==
X-Gm-Message-State: AOJu0YziTPMPk7Nq6joFnM0cuqAm1vCLX7l3sZWUNY9Itus40a/WYzr/
	6IZgfUotVS5ca+INbenPIby0iOtQXxai9LwuXSD6W5RvHfjiFjp3
X-Google-Smtp-Source: AGHT+IFLR15yr14KrH1V2XyHqsdG8LJTmA5VVaJ5mHLopXe4spL3e8/06Hn9zzmEUypa4rbuaindbA==
X-Received: by 2002:a17:906:c7d4:b0:a37:6d79:85da with SMTP id dc20-20020a170906c7d400b00a376d7985damr3772899ejb.47.1707296052956;
        Wed, 07 Feb 2024 00:54:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjgkDz5zEteAQxqYTDsLM+iX4X2DfXpjC2Xhg6J8AZnnr8xCgVokE7UcfJ37sw6T0TYFtkSvfVUPx9iSQ11vDJ+JgrNxWWRxrYwjWSLAcgq1u7ayURSCE8YjjnzOI0O8x2vyEpzm9rnPKdiW4SVJyuq/dW/HBox9Yg6iElzKS9erjccTaUt5yyj2BgKJF6ojAZDR0jqnkKQTDcyLvx9v1vhQF+1FHCRVAXgeBsk67Z4kOeScGnNcyda4lChEHehpRu+14EDLLR1wKyz1VOvLiKDHZ5cGXiXQdqx4H3gKeBnpFxKPivgziOaZxtlh+r7mQnAbOkt+jFtC8h5/HrIc7aAeZKFlMND4T0AW7bdZ96kFO1KuAXYmYcNNrHuTfV4iNddoCzxV2mNsI/DjEvfzmRVQfrlJfzch5nCHdRyVpGHHiOL6c=
Received: from [192.168.11.39] (54-240-197-227.amazon.com. [54.240.197.227])
        by smtp.gmail.com with ESMTPSA id oz14-20020a170906cd0e00b00a38620c3b3dsm503254ejb.198.2024.02.07.00.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 00:54:12 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e4fd8089-bbbf-4f54-98f5-211eac165ac2@xen.org>
Date: Wed, 7 Feb 2024 08:54:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 13/20] KVM: selftests / xen: map shared_info using HVA
 rather than GFN
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-14-paul@xen.org> <ZcMDjZ2t8XflbIpD@google.com>
Organization: Xen Project
In-Reply-To: <ZcMDjZ2t8XflbIpD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 04:14, Sean Christopherson wrote:
> Please stop making up random scopes.  Yes, I know "KVM: selftests:" is too coarse,
> bt everyone doing their own thing is worse.

So what would you suggest?

