Return-Path: <linux-kselftest+bounces-42150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5BDB95E4A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 14:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE9B18A2694
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D332341F;
	Tue, 23 Sep 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cqWc4AFf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86937322DBB
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632139; cv=none; b=MCUZcklRenxPz2z/lsOp4Ash9Ayl2qhy0UAP2znks6Jzkcxi7UOuicWqANhhMNdaqgtf0HAgYyrJprpODCMCLliE4GXz2XWTykA59983B6jwFusSRc59WAs6wiknE5D6reeNECP+rzs9FmIgHPD14YP82Yn8lZlXKHDxqK9zKy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632139; c=relaxed/simple;
	bh=eLS+3L+WH/3oUK1KdScdYxGZmccSVzRYZZWCamfUCQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SD53ZmEJ1Ml9AnTA+Yytv30r0/5php+eOh+zLnvse1CRvlP1/Pymbtjc1UwFtyOYmGo32Z65TXKec+Xe0ofVROSGF9WSxHS0EjetmtYYDFiLN5S5n/RfX7CaSyfgPZNFbTvJk7DXKdFgxvZzWN1PMEBF01vFS0LzRdieSxzKlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cqWc4AFf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f0308469a4so2166490f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758632136; x=1759236936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaIg4jDl9jFZTYzzE1kP2lbNTLyhNR0UhkVfuAOFPbU=;
        b=cqWc4AFfAM96UtCVjz/5MIqSxFEpPwa+74UA3pacyceoShYe+nPmCjrueOs5X0idj9
         QQEkIR2ZLsFpbqHA4WKPfAH/jyks3sNE4h6MlCnyGtpZE483XMy+nPYx3HQb11vjAmHX
         yIJAZEp7V6PPxkPnC0fsMhlNGX8TJ/4q97r5AUEoY7wEBQLZMgjbCMbauzInMaWflFOx
         iUO7aisFvjVCpxvgqKND8a0nJh05mzOTqR1t58tnmgsTV2QuotTYxa/PDbBi3rSxkdRz
         K+cX3GmR2q3RSba0Jrq1vX1nAj1Km4dEEbA/5rjg5MLgr8cEv2GzieHQzp7xKIxxoYl0
         j6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632136; x=1759236936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaIg4jDl9jFZTYzzE1kP2lbNTLyhNR0UhkVfuAOFPbU=;
        b=RhpzWjPLS2Zco0qAYgGiFnA6A/90MklyVj/9ls0lxPO4H1/HgTFD1KdWMTleSz/nZ0
         KK3PRWhEeK6LmgLdCxi8nEIWFPuQ5N7NeyXAjT/eIB3wDJeZM5tK6YgSonxgoRnZR+uQ
         sg46mj2aiEdzz7r3G5170oKXcbsXJ8jdo98h6lk+k7v4kkUiDjrqIVNAWdKpNjndZrhA
         NhqdSPbHkHeFRGc7qeAm3UJrOeVlApfEz7M8KwSoLtnW0gJ1w1m1A2gNrrcAJroJSdxA
         s1krl8NHFun9xn6S0r0huXZMYPIBg0vz47JZfOjtwqzCEAA5EKtD1L11irhcyF8ggEbl
         VvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4F2pB/5hSObYW1eb3b/t4nqwYdrxw7wNY54VK+Ad5a1YfRMdVu8oPS4jIZ8XbEL+/t0bZz+tswdWeWLwnGns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OUgd5cxRrUV1eoudSzkyORYAtk9mI2L6Po54P895CcrF55Tr
	aVTQgbT+FO2JCK0TbCTEmrlUfFxK+3DE7q1J15pGGXYHkICfHSxO3nfG+McWuqVWWgg=
X-Gm-Gg: ASbGncugIdkwBO8ZnoDs+ScXv5oybxtzP4OS1pLRnypH1VX5i7G1V2KibKn9zvKwdx1
	53AGt1ayD8wQNkCh5VnVdxciPH8N+xB4IJsoIpltgmtJ0loAtj5qBrbkZJe//fUIvOUjG5TYHzf
	MMisLAO9qQg38y7oK717Lf9vMCqrzRqWSso1TLcnT0P5N1WTaIaAM/Kt/ABx+kaWjrbm2MIKn3c
	NabBl8DzWFnMgW+nnbglBQjaM5KiOzJu+iZ76xuvPyiNx0EkJjGoVYJHegFyyq/xnTBxakHx2as
	f7FtCNCmZb6dFTnz7Xp0sqRN+phJ3hPB+FzjMS6DugfM0ZGaS9eF1N8sGlSRcFpFOkO7965G5Dr
	dzbsj0pOta9FyK9o8rp8Amy3oCIyXX3nb3Dp+KtHo+as=
X-Google-Smtp-Source: AGHT+IG0uyoZNs0i41rqkNkMaZFqouCej55fWirbDUl/J5m3XVuK1w9+Aykmm/3MDPy3vac3H7+Wyg==
X-Received: by 2002:a05:6000:4025:b0:3e4:957d:d00 with SMTP id ffacd0b85a97d-405cb9a5225mr1756055f8f.58.1758632135758;
        Tue, 23 Sep 2025 05:55:35 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a286edsm273702715e9.16.2025.09.23.05.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:55:35 -0700 (PDT)
Message-ID: <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
Date: Tue, 23 Sep 2025 14:55:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>,
 Sami Tolvanen <samitolvanen@google.com>, Richard Weinberger
 <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250912230208.967129-2-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/25 12:59 AM, Brian Norris wrote:
> The PCI framework supports "quirks" for PCI devices via several
> DECLARE_PCI_FIXUP_*() macros. These macros allow arch or driver code to
> match device IDs to provide customizations or workarounds for broken
> devices.
> 
> This mechanism is generally used in code that can only be built into the
> kernel, but there are a few occasions where this mechanism is used in
> drivers that can be modules. For example, see commit 574f29036fce ("PCI:
> iproc: Apply quirk_paxc_bridge() for module as well as built-in").
> 
> The PCI fixup mechanism only works for built-in code, however, because
> pci_fixup_device() only scans the ".pci_fixup_*" linker sections found
> in the main kernel; it never touches modules.
> 
> Extend the fixup approach to modules.
> 
> I don't attempt to be clever here; the algorithm here scales with the
> number of modules in the system.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/pci/quirks.c   | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/module.h | 18 ++++++++++++
>  kernel/module/main.c   | 26 ++++++++++++++++++
>  3 files changed, 106 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d97335a40193..db5e0ac82ed7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -207,6 +207,62 @@ extern struct pci_fixup __end_pci_fixups_suspend_late[];
>  
>  static bool pci_apply_fixup_final_quirks;
>  
> +struct pci_fixup_arg {
> +	struct pci_dev *dev;
> +	enum pci_fixup_pass pass;
> +};
> +
> +static int pci_module_fixup(struct module *mod, void *parm)
> +{
> +	struct pci_fixup_arg *arg = parm;
> +	void *start;
> +	unsigned int size;
> +
> +	switch (arg->pass) {
> +	case pci_fixup_early:
> +		start = mod->pci_fixup_early;
> +		size = mod->pci_fixup_early_size;
> +		break;
> +	case pci_fixup_header:
> +		start = mod->pci_fixup_header;
> +		size = mod->pci_fixup_header_size;
> +		break;
> +	case pci_fixup_final:
> +		start = mod->pci_fixup_final;
> +		size = mod->pci_fixup_final_size;
> +		break;
> +	case pci_fixup_enable:
> +		start = mod->pci_fixup_enable;
> +		size = mod->pci_fixup_enable_size;
> +		break;
> +	case pci_fixup_resume:
> +		start = mod->pci_fixup_resume;
> +		size = mod->pci_fixup_resume_size;
> +		break;
> +	case pci_fixup_suspend:
> +		start = mod->pci_fixup_suspend;
> +		size = mod->pci_fixup_suspend_size;
> +		break;
> +	case pci_fixup_resume_early:
> +		start = mod->pci_fixup_resume_early;
> +		size = mod->pci_fixup_resume_early_size;
> +		break;
> +	case pci_fixup_suspend_late:
> +		start = mod->pci_fixup_suspend_late;
> +		size = mod->pci_fixup_suspend_late_size;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (!size)
> +		return 0;
> +
> +	pci_do_fixups(arg->dev, start, start + size);
> +
> +	return 0;
> +}
> +
>  void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>  {
>  	struct pci_fixup *start, *end;
> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>  		return;
>  	}
>  	pci_do_fixups(dev, start, end);
> +
> +	struct pci_fixup_arg arg = {
> +		.dev = dev,
> +		.pass = pass,
> +	};
> +	module_for_each_mod(pci_module_fixup, &arg);

The function module_for_each_mod() walks not only modules that are LIVE,
but also those in the COMING and GOING states. This means that this code
can potentially execute a PCI fixup from a module before its init
function is invoked, and similarly, a fixup can be executed after the
exit function has already run. Is this intentional?

>  }
>  EXPORT_SYMBOL(pci_fixup_device);
>  
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 3319a5269d28..7faa8987b9eb 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -539,6 +539,24 @@ struct module {
>  	int num_kunit_suites;
>  	struct kunit_suite **kunit_suites;
>  #endif
> +#ifdef CONFIG_PCI_QUIRKS
> +	void *pci_fixup_early;
> +	unsigned int pci_fixup_early_size;
> +	void *pci_fixup_header;
> +	unsigned int pci_fixup_header_size;
> +	void *pci_fixup_final;
> +	unsigned int pci_fixup_final_size;
> +	void *pci_fixup_enable;
> +	unsigned int pci_fixup_enable_size;
> +	void *pci_fixup_resume;
> +	unsigned int pci_fixup_resume_size;
> +	void *pci_fixup_suspend;
> +	unsigned int pci_fixup_suspend_size;
> +	void *pci_fixup_resume_early;
> +	unsigned int pci_fixup_resume_early_size;
> +	void *pci_fixup_suspend_late;
> +	unsigned int pci_fixup_suspend_late_size;
> +#endif
>  
>  
>  #ifdef CONFIG_LIVEPATCH
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b26184936..50a80c875adc 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  					      sizeof(*mod->kunit_init_suites),
>  					      &mod->num_kunit_init_suites);
>  #endif
> +#ifdef CONFIG_PCI_QUIRKS
> +	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
> +					    sizeof(*mod->pci_fixup_early),
> +					    &mod->pci_fixup_early_size);
> +	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
> +					     sizeof(*mod->pci_fixup_header),
> +					     &mod->pci_fixup_header_size);
> +	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
> +					    sizeof(*mod->pci_fixup_final),
> +					    &mod->pci_fixup_final_size);
> +	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
> +					     sizeof(*mod->pci_fixup_enable),
> +					     &mod->pci_fixup_enable_size);
> +	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
> +					     sizeof(*mod->pci_fixup_resume),
> +					     &mod->pci_fixup_resume_size);
> +	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
> +					      sizeof(*mod->pci_fixup_suspend),
> +					      &mod->pci_fixup_suspend_size);
> +	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
> +						   sizeof(*mod->pci_fixup_resume_early),
> +						   &mod->pci_fixup_resume_early_size);
> +	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
> +						   sizeof(*mod->pci_fixup_suspend_late),
> +						   &mod->pci_fixup_suspend_late_size);
> +#endif
>  
>  	mod->extable = section_objs(info, "__ex_table",
>  				    sizeof(*mod->extable), &mod->num_exentries);

Nit: I suggest writing the object_size argument passed to section_objs()
here directly as "1" instead of using sizeof(*mod->pci_fixup_...) =
sizeof(void). This makes the style consistent with the other code in
find_module_sections().

-- 
Thanks,
Petr

