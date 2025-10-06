Return-Path: <linux-kselftest+bounces-42790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3BEBBFBAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 00:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01F4189783E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 22:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126A1FCFFC;
	Mon,  6 Oct 2025 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M4kP3F8h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37219C553
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Oct 2025 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791498; cv=none; b=YeX+FbWmbErNr9vu006lC2uCZ7orbODKtEj4Lt25sAgv1IQnxlTt/q5nyBrfg2lL+Is46HuJ4YXwc/uvtzbgRSci+uychjWd71m1TaV7OXFRvy0cLBPRAIzT7+bb//XY7ukQVh1n/lfMHFZrJctwYKMjAukvTktojTfAB1VeFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791498; c=relaxed/simple;
	bh=Lxcy5NL3Pu34Y9yZDrN3rk4ENVzLB2VJ2gFBFJRiZe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orn+TFPwR3RKqVQ9k5PRUYl5CKMPokUN4DpvsT6C6nE/4BwqIzi/35nRr+EsBzkelrb2vbS+H4OstdijPgfzsqxeMgVWYq/yQqlxHkS1ofgT6bbnGDaiNgJH0Pi8/PsT+C8V2Q8qtsdnwxzUCbAwoZDDKBYDtT4Rq7cBSSDK73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M4kP3F8h; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b551350adfaso5012662a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791495; x=1760396295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/BzR3xcFJ27hJdoJBLSQ8cx3Y7ne92fXQ6+nL97RBI=;
        b=M4kP3F8h1g2h/2LVC8k+gEdvyFalaLxxhi0boU2ms9csn7D1qhDuu9DZhemPuTizfP
         LkiecPIxTfoI3hrpGqKq/4xfGOjtP/078WK/I8tW/0Idm0y75by/92PZg3m0dhXB8/sJ
         yq4mBd5DO7cgp3BIdIRP3Wg7rdfxJg+brrp4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791495; x=1760396295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/BzR3xcFJ27hJdoJBLSQ8cx3Y7ne92fXQ6+nL97RBI=;
        b=TC7fdEdVi3RK0zLmE/gQlpo8O6RxSSI/PoGRcUKIS/cq52GLH30eqq7hg7ME5/6NS6
         RgAYv72M2Oy9tWxttIYaHnUk1/DaAV6BTs7dTDFFL3A/nPrTuoEjctK/w8peAgPfoFfJ
         llF1ujjdGGq5YSbOYYgha+9SpyGsfxUSyXUo2uIj/c6nSKro894NB9RQP8FF2IUEiHtY
         HUf/QYXhIfBQNI5SnX9tFznBHfDIxTO3LAGm4vbkXjZvlrIvE1XcnRsAXUDFP7ZuDL6P
         FhBwSdo/haN/Dy25wRGojbaYdJ3LB794XaRcYmgxH6Ysit3JEPnnqosP44naYL5Nf4IS
         2YrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4C68UJWcC3yapiouD5F+rvNICaK2sc1pqyBeb/McP7yT0iR2iawQ57B+TkfB2g5vh84N99qZe1pnGcuDOI24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuJS5QMLLwF23vCzgmjYI0kAQYAsHBaJq5wO7Ga85sPMQO1oX
	0ZjiRHNrGvP377ViSHweBCai7lUeO7DJx0nCHPnaLb/qoqOA7Y2VG5+0UT1g2dwtdA==
X-Gm-Gg: ASbGncuCnR+KDjWgiCas6w6cNiKM95ZFmXLOsGstWfWj6yy7bGHi5kEfUX6QjQ2Zonw
	KVcHw3wwM9ptay8mWLCaduBFX8fCmXikDpQFPTReDgGo0GbqHNi+DNjmF9prpjLs+a1BdNZ779N
	LGR/7g1VSOWhv3tPGVjYTpegU3MgWQxBIxZWsNezHR113LrvgMDvR5GgHyyU1DDFdj8EnB9ukt7
	KpU7cDCkY8nsIbl/ENcrHauV+hLvG5GlXKCkXeJyHaZ9CP7bp7/tzlfaLa+TZ7NkebXJiO+h/3H
	eTN4P17NDYsZVxFWDLF+lxyt963CL+SbE47+tixIydYPiZGl7P5KlllQKP58/rYmCFMyuy6m9Bg
	ZefXnv4ySlEsFvZVFdFAt6zXFvctds8AJUwrMe6pFjOCs9zISyalQmgjSMuqJd24pBLoZQI1ebV
	BGZXaFqwvi
X-Google-Smtp-Source: AGHT+IGVZN5motWy2Ycd10vl3SQ+AaFTmr4hj0xbObvYJTiiiEPPzlHnJXWtgHFm0rxdlAP5PbSCnQ==
X-Received: by 2002:a17:903:2ac3:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-28e9a679f43mr160020265ad.46.1759791494873;
        Mon, 06 Oct 2025 15:58:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:299e:f3e3:eadb:de86])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1d5e20sm143991805ad.97.2025.10.06.15.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 15:58:14 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:58:12 -0700
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
Message-ID: <aORJhL1yAPyV7YAW@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
 <aNLb9g0AbBXZCJ4m@google.com>
 <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>

Hi Petr,

On Wed, Sep 24, 2025 at 09:48:47AM +0200, Petr Pavlu wrote:
> On 9/23/25 7:42 PM, Brian Norris wrote:
> > Hi Petr,
> > 
> > On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
> >> On 9/13/25 12:59 AM, Brian Norris wrote:
> >>> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
> >>>  		return;
> >>>  	}
> >>>  	pci_do_fixups(dev, start, end);
> >>> +
> >>> +	struct pci_fixup_arg arg = {
> >>> +		.dev = dev,
> >>> +		.pass = pass,
> >>> +	};
> >>> +	module_for_each_mod(pci_module_fixup, &arg);
> >>
> >> The function module_for_each_mod() walks not only modules that are LIVE,
> >> but also those in the COMING and GOING states. This means that this code
> >> can potentially execute a PCI fixup from a module before its init
> >> function is invoked, and similarly, a fixup can be executed after the
> >> exit function has already run. Is this intentional?
> > 
> > Thanks for the callout. I didn't really give this part much thought
> > previously.
> > 
> > Per the comments, COMING means "Full formed, running module_init". I
> > believe that is a good thing, actually; specifically for controller
> > drivers, module_init() might be probing the controller and enumerating
> > child PCI devices to which we should apply these FIXUPs. That is a key
> > case to support.
> > 
> > GOING is not clearly defined in the header comments, but it seems like
> > it's a relatively narrow window between determining there are no module
> > refcounts (and transition to GOING) and starting to really tear it down
> > (transitioning to UNFORMED before any significant teardown).
> > module_exit() runs in the GOING phase.
> > 
> > I think it does not make sense to execute FIXUPs on a GOING module; I'll
> > make that change.
> 
> Note that when walking the modules list using module_for_each_mod(),
> the delete_module() operation can concurrently transition a module to
> MODULE_STATE_GOING. If you are thinking about simply having
> pci_module_fixup() check that mod->state isn't MODULE_STATE_GOING,
> I believe this won't quite work.

Good point. I think this at least suggests that this should hook into
some blocking point in the module-load sequence, such as the notifiers
or even module_init() as you suggest below.

> > Re-quoting one piece:
> >> This means that this code
> >> can potentially execute a PCI fixup from a module before its init
> >> function is invoked,
> > 
> > IIUC, this part is not true? A module is put into COMING state before
> > its init function is invoked.
> 
> When loading a module, the load_module() function calls
> complete_formation(), which puts the module into the COMING state. At
> this point, the new code in pci_fixup_device() can see the new module
> and potentially attempt to invoke its PCI fixups. However, such a module
> has still a bit of way to go before its init function is called from
> do_init_module(). The module hasn't yet had its arguments parsed, is not
> linked in sysfs, isn't fully registered with codetag support, and hasn't
> invoked its constructors (needed for gcov/kasan support).

It seems unlikely that sysfs, codetag, or arguments should matter much.
gcov and kasan might be nice to have though.

> I don't know enough about PCI fixups and what is allowable in them, but
> I suspect it would be better to ensure that no fixup can be invoked from
> the module during this period.

I don't know of general rules, but they generally do pretty minimal work
to adjust various fields in and around 'struct pci_dev', to account for
broken IDs. Sometimes they need to read a few PCI registers. They may
even tweak PM-related features. It varies based
on what kind of "quriky" devices need to be handled, but it's usually
pretty straightforward and well-contained -- not relying on any kind of
global state, or even all that much specific to the module in question
besides constant IDs.

(You can peruse drivers/pci/quirks.c or the various other files that use
DECLARE_PCI_FIXUP_*() macros, if you're curious.)

> If the above makes sense, I think using module_for_each_mod() might not
> be the right approach. Alternative options include registering a module
> notifier or having modules explicitly register their PCI fixups in their
> init function.

I agree module_for_each_mod() is probably not the right choice, but I'm
not sure what the right choice is.

register_module_notifier() + keying off MODULE_STATE_COMING before
pulling in the '.pci_fixup*' list seems attractive, but it still comes
before gcov/kasan.

It seems like "first thing in module_init()" would be the right choice,
but I don't know of a great way to do that. I could insert PCI-related
calls directly into do_init_module() / delete_module(), but that doesn't
seem very elegant. I could also mess with the module_{init,exit}()
macros, but that seems a bit strange too.

I'm open to suggestions. Or else maybe I'll just go with
register_module_notifier(), and accept that there may some small
downsides still.

Thanks,
Brian

