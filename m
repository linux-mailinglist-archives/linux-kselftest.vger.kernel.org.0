Return-Path: <linux-kselftest+bounces-42155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A80CB97105
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 19:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DE42E1B3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36AF281503;
	Tue, 23 Sep 2025 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DMM9b5Aj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9B280025
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649338; cv=none; b=pYxZA8LIijZEXulCU9t1/uI0IROoa/m4M06VKO9fO/9AtELrbGpL0p252NFGSoKM7popC7ChaBggCwssbbMG7AtaURDXlOE8b09inXsY5wk/bRp3Sq95SS8NxwEWboHgNaSqDhMCFWX5PortyNngwF6/yWi1BlvikL/lgUnAZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649338; c=relaxed/simple;
	bh=6G5hq2ESPXxgPR53Lq8sJO77YPWnS5k2F15nLBfDTQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDToA3yqwJyfq445cUmeNqvZDuzNyayvo7U2x4JhWgtvY/Wwy7zCQ6Pb/h+RhgiRa2tFozL6zICveVGUderkPuVDVv22whfhTD4Srg4OgxyXnH4H0mk0mlmr7fkUkDbX2o5tGvZzpDjuUCwkVGOeWgym+XOhiPpmlrqCuXhSmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DMM9b5Aj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso2755576a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758649336; x=1759254136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=;
        b=DMM9b5Ajy3IOhVOBk7y54ekzwIDr/1TF22r4z5B6hOlNuDv0FPMAs3EJFbw8+CNalH
         B6GTxKMqrVAo/OCFJDkpoRwvSuklRmz7QOkErP4zua26IKf+tC6ZFFeY4UDGml8mBjEI
         ULPNyc5PoNtn1Ff3XocHVciCu6I2k3c+JaXxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649336; x=1759254136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=;
        b=w67Sn0rgWLyGcp86HyCu7/VQ85L/27BK8HqcPeHCj8puTNhOhveHqe84jSnPQMvka9
         P8E2C7Png/F1z95BkmyBjTLyCOqwpAXeTi3pVkEJ4Fj/8lkyZMgGJKaqbEjXcO106tnK
         5NY3HsHei2kOi+fNzF7rdyyBd0heepR/ukbDaoTDlKMSg1KFOTbjkm5UMMy8KCMjYEZ2
         HdBnzbk6uSR0ChuCa8TrUR65SwqHxCnFunnY+6lga70LYX9IF3Mh1U6Go501D89YcEzw
         KnNKiyTWLoQLjEUkoMe8efdJ4HP2+8yvlM9LAGaAut87WlC60DWCPtoe7t0D6I0LM+k6
         DktA==
X-Forwarded-Encrypted: i=1; AJvYcCXZbOAougGrUckvvuRxxYEb/AMZI142BCAaeemh253vrb2nNDx4YNyXofj1DmEztgCtBHJXFYDpoSc4tZeGsIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyxP5T+OqByx8ZRVO0T2usb5pofqjaZjI1Ogv9AjjHDkxdevEr
	ig2YfGjzHB6knMXCrDQkQpC1x+6loFL0GNMFrGtu14qS3ElqlPgMh6P0HsqYDF4p9A==
X-Gm-Gg: ASbGncub9LxUBD/Gpm6kKVKfFJfa7HlJekjCjdEU7YZ7YSIOQqjW9dNEItf0ceQPZSZ
	1+/uH2qBaGA0GZ8ARp3SiJKw1Yip3B1WNfOq6LVxBl5t9jERP8aprGKx6XSvAviSQ0iRhkmIvGK
	FMBGc9YhHDoaHARuKCLMtNW74O8OJDGWx2BwtC+z3i9Aw0xqKfExwp+nql02NYbfAUsLrvidrUg
	QXenqZFHqC/RYQBq9G361cfWoAE9PzuQKPJCI+bBEl+Cbo86O9gbBLZGDAPCVOLAs0TLbeaMrbL
	pa16Dffk5rBVnxVVrDV3xWPOoEc/8vpbKhEIsRFMDMri/RuCZD0GVFSUnnqvrLpARYvn1imhFPj
	TeFiSpP6mmY3y4R+Kqzi5xKTxIvwGoCSHPHv9LqXjPQz4QefDh89hjUtRSw3RizSw5kVxSdsFaY
	hwQGw=
X-Google-Smtp-Source: AGHT+IHJbwEaaCpD6dZUF3mz350pgxjUUNoYTVUR2WMjcFJjbWFfvBHQKr1Y1HlZkG2OkTtL8B8Dkg==
X-Received: by 2002:a17:90b:3cc5:b0:32e:8931:b59c with SMTP id 98e67ed59e1d1-332a9909c66mr4171539a91.27.1758649336532;
        Tue, 23 Sep 2025 10:42:16 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f126:ac9b:b8ac:e280])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33060803335sm17000731a91.24.2025.09.23.10.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 10:42:15 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:42:14 -0700
From: Brian Norris <briannorris@chromium.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
Message-ID: <aNLb9g0AbBXZCJ4m@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>

Hi Petr,

On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
> On 9/13/25 12:59 AM, Brian Norris wrote:
> > @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
> >  		return;
> >  	}
> >  	pci_do_fixups(dev, start, end);
> > +
> > +	struct pci_fixup_arg arg = {
> > +		.dev = dev,
> > +		.pass = pass,
> > +	};
> > +	module_for_each_mod(pci_module_fixup, &arg);
> 
> The function module_for_each_mod() walks not only modules that are LIVE,
> but also those in the COMING and GOING states. This means that this code
> can potentially execute a PCI fixup from a module before its init
> function is invoked, and similarly, a fixup can be executed after the
> exit function has already run. Is this intentional?

Thanks for the callout. I didn't really give this part much thought
previously.

Per the comments, COMING means "Full formed, running module_init". I
believe that is a good thing, actually; specifically for controller
drivers, module_init() might be probing the controller and enumerating
child PCI devices to which we should apply these FIXUPs. That is a key
case to support.

GOING is not clearly defined in the header comments, but it seems like
it's a relatively narrow window between determining there are no module
refcounts (and transition to GOING) and starting to really tear it down
(transitioning to UNFORMED before any significant teardown).
module_exit() runs in the GOING phase.

I think it does not make sense to execute FIXUPs on a GOING module; I'll
make that change.

Re-quoting one piece:
> This means that this code
> can potentially execute a PCI fixup from a module before its init
> function is invoked,

IIUC, this part is not true? A module is put into COMING state before
its init function is invoked.


> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
> >  					      sizeof(*mod->kunit_init_suites),
> >  					      &mod->num_kunit_init_suites);
> >  #endif
> > +#ifdef CONFIG_PCI_QUIRKS
> > +	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
> > +					    sizeof(*mod->pci_fixup_early),
> > +					    &mod->pci_fixup_early_size);
> > +	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
> > +					     sizeof(*mod->pci_fixup_header),
> > +					     &mod->pci_fixup_header_size);
> > +	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
> > +					    sizeof(*mod->pci_fixup_final),
> > +					    &mod->pci_fixup_final_size);
> > +	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
> > +					     sizeof(*mod->pci_fixup_enable),
> > +					     &mod->pci_fixup_enable_size);
> > +	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
> > +					     sizeof(*mod->pci_fixup_resume),
> > +					     &mod->pci_fixup_resume_size);
> > +	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
> > +					      sizeof(*mod->pci_fixup_suspend),
> > +					      &mod->pci_fixup_suspend_size);
> > +	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
> > +						   sizeof(*mod->pci_fixup_resume_early),
> > +						   &mod->pci_fixup_resume_early_size);
> > +	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
> > +						   sizeof(*mod->pci_fixup_suspend_late),
> > +						   &mod->pci_fixup_suspend_late_size);
> > +#endif
> >  
> >  	mod->extable = section_objs(info, "__ex_table",
> >  				    sizeof(*mod->extable), &mod->num_exentries);
> 
> Nit: I suggest writing the object_size argument passed to section_objs()
> here directly as "1" instead of using sizeof(*mod->pci_fixup_...) =
> sizeof(void). This makes the style consistent with the other code in
> find_module_sections().

Ack.

Thanks,
Brian

