Return-Path: <linux-kselftest+bounces-1826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9188112E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC76B2821EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708282D039;
	Wed, 13 Dec 2023 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJJqpHn6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB4E3
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702474293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dC8eAG+rdDz771HyG+6UKW1N21lq1IFcm8wzo/9j4Ag=;
	b=gJJqpHn6P9DZfGowORawvXOVVYLVpHsrgWGfPv+L9Tw8bl/SgW2brt7Or4lI6SvhR/AYc+
	RGKVpGBkSLbzBkTPpDmDt24zKaGS4Ll8D1g+nIUpNEe6tkAyZmcKDUvll3Rmq35D7nOBwy
	XkHA/A1hvcafWQYiPQPyrBjJKnXcAKE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-d91iIjmvOb-NqLASPCdVNQ-1; Wed, 13 Dec 2023 08:31:32 -0500
X-MC-Unique: d91iIjmvOb-NqLASPCdVNQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1f9ab28654so160589566b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 05:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474291; x=1703079091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dC8eAG+rdDz771HyG+6UKW1N21lq1IFcm8wzo/9j4Ag=;
        b=wECR+DL27LsMPZ0PfCnZNZsQuUCEaKpIY0qtFoeDbD9G9RINlYt9X5N63lmfAXCJps
         jtMlghTCHiAVdkKVFkvq/PmSiHvzfHGi0qrwSauo3f8EyPVACapvsmxnEk9hsr26W5SH
         RjKMQidsYSae61wi96rdBHA0KR1Fnholm1U18WymrdGOpnSeqb8BSCz2ouYRK3hfTYec
         LcBIYzjEgOHC+88yTc2QO1DGTOQlCV3ACEc+9r/Wen07NvWbXsk3sh9Uc9N2JZ4tBRQP
         L2/s+SNLZm7QBgRkItCaXIzfFThjL43mnvvf5oEh1vsDbLGbGIquhev7RlJXwfjljeZY
         DgQA==
X-Gm-Message-State: AOJu0YxS+aN/NmOEeOI9ohO1BKr+tC+SSqiY5RIzYnIp7caDct3vbMPv
	BGeRpADTTWpXKM5+QdPdYWoomXNc/6yDRRnty7D1c2xEvtjIkT5zv6yyFIKIR4BVU0qcZZT+qFZ
	+srFOv3wpY0wHRQofK5/nFFHqLSt+xGvQ4sC0
X-Received: by 2002:a17:906:b204:b0:a19:a1ba:8ce0 with SMTP id p4-20020a170906b20400b00a19a1ba8ce0mr3653205ejz.126.1702474290993;
        Wed, 13 Dec 2023 05:31:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMRBYvxquPjKh2oUpzsQZ4YofuMOR/BRB0u9Mr+JzAm33S9FD+0/e2kUugVLkdr9DckuEDFQ==
X-Received: by 2002:a17:906:b204:b0:a19:a1ba:8ce0 with SMTP id p4-20020a170906b20400b00a19a1ba8ce0mr3653199ejz.126.1702474290682;
        Wed, 13 Dec 2023 05:31:30 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id tg10-20020a1709078dca00b00a178b965899sm7819372ejc.100.2023.12.13.05.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:31:30 -0800 (PST)
Message-ID: <a2e25f7c-dd5b-4c88-b25a-4d8ddc8b7f29@redhat.com>
Date: Wed, 13 Dec 2023 14:31:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] KVM: selftests: Initialise dynamically
 allocated configuration names
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Haibo Xu <haibo1.xu@intel.com>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231211-kvm-get-reg-list-str-init-v3-1-6554c71c77b1@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231211-kvm-get-reg-list-str-init-v3-1-6554c71c77b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/23 14:08, Mark Brown wrote:
> When we dynamically generate a name for a configuration in get-reg-list
> we use strcat() to append to a buffer allocated using malloc() but we
> never initialise that buffer. Since malloc() offers no guarantees
> regarding the contents of the memory it returns this can lead to us
> corrupting, and likely overflowing, the buffer:
> 
>    vregs: PASS
>    vregs+pmu: PASS
>    sve: PASS
>    sve+pmu: PASS
>    vregs+pauth_address+pauth_generic: PASS
>    X�vr+gspauth_addre+spauth_generi+pmu: PASS
> 
> Initialise the buffer to an empty string to avoid this.

> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index be7bf5224434..dd62a6976c0d 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -67,6 +67,7 @@ static const char *config_name(struct vcpu_reg_list *c)
>   
>   	c->name = malloc(len);
>   
> +	c->name[0] = '\0';
>   	len = 0;
>   	for_each_sublist(c, s) {
>   		if (!strcmp(s->name, "base"))
>  			continue;
>  		strcat(c->name + len, s->name);

This can be fixed just by s/strcat/strcpy/, but there's also an ugly 
hidden assumption that for_each_sublist runs at least one iteration of 
the loop; otherwise, the loop ends with a c->name[-1] = '\0';

>                 len += strlen(s->name) + 1;
>                 c->name[len - 1] = '+';
>         }
>         c->name[len - 1] = '\0';

Now this *is* a bit academic, but it remains the fact that all the 
invariants are screwed up and while we're fixing it we might at least 
fix it well.

So let's make the invariant that c->name[0..len-1] is initialized.  Then 
every write is done with either strcpy of c->name[len++] = '...'.

> ---
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> change-id: 20231012-kvm-get-reg-list-str-init-76c8ed4e19d6
> 
> Best regards,


