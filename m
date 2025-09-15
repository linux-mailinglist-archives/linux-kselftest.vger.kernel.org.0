Return-Path: <linux-kselftest+bounces-41526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85058B58604
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 22:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A2E7A5E82
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3A295516;
	Mon, 15 Sep 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZ2+sUIi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4F28DF2D
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967916; cv=none; b=jYEkA0+F4HFKNDPfNpc/LE2RRhYVpD2b3AYXuvOQg/NXRg+NIkDs5FqskM7jsUZ91F/YMPraSo3MASepOsYGyuA1is7VLsAFd8XOLUI3ZG5u3ZffYkSEVXGs86tHu5b8NpOg4280V0TTqS8uMhxGfhbFJ25LFv6B+glND+NjjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967916; c=relaxed/simple;
	bh=Oo9wGMZhnst9JKD4ApAAC3zg3Wq/VvmKzOk8qOj+8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNPYB+bT23CRVFHzY7rsIkYckkzK6r8TRQ2ffok5BHwdOd75isOTomVR/uNxVGMuul55/2VCisq1LGHATCM5m24EZYsV4Tc5ExU7DPHUdXZ5XbGiL5d0rwIgsXEAyrS5ucUHpp33YR5EGjE+W6Kbf2C0jc0uiAyZLY+uUzFKS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hZ2+sUIi; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b52047b3f19so3299264a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757967914; x=1758572714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O72yw8vJtQy+8bHFkvEUobUMXSH/AYeLaHaVDBYLJyk=;
        b=hZ2+sUIi9pf3OXUUBWGgpMI5lz3YNtMyjManCGjlhT68Jf3aWAX5gEb5flACSwLeL8
         m2NKLGcinlGwgkrukw+lUQlIYAIY64+ywTzk6KEe4qXidGdBLOw4LqXS+4INsGIDyduM
         P3TVtGcqXTsoY5Pk6PsMJsRqcGMDib280YHfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967914; x=1758572714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O72yw8vJtQy+8bHFkvEUobUMXSH/AYeLaHaVDBYLJyk=;
        b=gvX0WotMiS0YlJ0HE/Jxcn2NcE0keYip3ljrUYvARXm+5exJKjFFypeLcKee71qgc5
         Llzs3NQHzmzEBp8ea1etcmgWcwN0Fm2LuBIxZWNSyTzSXOARqC8wdQqVqnEIFxofeR+U
         XZKhVl8Wl38HlzhI3Kb8WI4IBGuj3tksWi5B3ujxiJ18Xgsc90ZlHEl36PfK0UwfE6t/
         L4z8NqcmjddVok6+Hd2jyo1hJU7QxQe4DY1klIDyrKQIWxz99D/pO2ZXTpoWuXDiJKzP
         MPvSz8+eYpdeLX3Dg2e5MSq5LLbMWs/AEjSjXW8s5P8H0A5R7SuXpjyXaMCIQVaPAI3p
         Iy5w==
X-Forwarded-Encrypted: i=1; AJvYcCV9n842//6FzstjJDAy2KsmrUdXw6mvCxZ4ImxeeZHj59Uk5Kp4MGfjxvzWC14atXMupON2xfo515hWtS+2r0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+eFF2su2ecoLC1e7jmpF5o77+0uWzO3nJpNN49Odt+zEKh5T
	PgnhXmbfqQvHUC06S507DEMmhsqqXIwMvpaSjFg88sHOgR/KDVFqRPra77BrnCSECA==
X-Gm-Gg: ASbGncu20LlAVaGzw3IMxhCaOovsqV8UX9iyaJN3IHf8Kh38GKkCWFEJ+lUUhizpwIN
	ni6/XQsfXO1wHJ+SzK05AubGPXulmG7wIz5F3yi33/WrF/17o4XDNto8vtHf6JDM6y+HrgPZRxJ
	P3boQF8TMLzauCwt/HkGYJqn4SYkjw9X8iVAD8wiv1kpVYRxePwo4rpG1TVPDztstX9sUMHwsuM
	gGaOQ5+x40aBHin+tjmtT5HB3n7hhjecQsUcCPlkoMrF3wOvnQuxNL3IzqNjbM3lwAgeFlwA17f
	NEylpIHN95fdfuMlpngVc7LUhVL8HxWB/UflJ4pz9UjQz70WLMDeeT1OTgkrT3RUNOncnxk8ODM
	6EsLOiSmgdCZOzasjOjVrQiQMlxbqtsOGoJsKbVkuyATZSZpKTECTCCAmubkuvJ2HxvZKI7U=
X-Google-Smtp-Source: AGHT+IH0BB3qybe2HQfIXVITegc2cfF0wfUP7hE62PhWgnHrlmUKZL5W+LGvMXTHhPZvp8uroV0xQA==
X-Received: by 2002:a17:902:ebc2:b0:24b:25f:5f7f with SMTP id d9443c01a7336-25d2801094emr140529445ad.60.1757967913824;
        Mon, 15 Sep 2025 13:25:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:fd49:49b1:16e7:2c97])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25fc8285639sm86930085ad.134.2025.09.15.13.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 13:25:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:25:11 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
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
Subject: Re: [PATCH 2/4] PCI: Add KUnit tests for FIXUP quirks
Message-ID: <aMh2J1K_YiWYaNxf@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-3-briannorris@chromium.org>
 <aMfJCbld_TMHPTbD@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMfJCbld_TMHPTbD@google.com>

Hi,

On Mon, Sep 15, 2025 at 08:06:33AM +0000, Tzung-Bi Shih wrote:
> On Fri, Sep 12, 2025 at 03:59:33PM -0700, Brian Norris wrote:
> > +static int test_config_read(struct pci_bus *bus, unsigned int devfn, int where,
> > +			    int size, u32 *val)
> > +{
> > +	if (PCI_SLOT(devfn) > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	if (where + size > TEST_CONF_SIZE)
> > +		return PCIBIOS_BUFFER_TOO_SMALL;
> > +
> > +	if (size == 1)
> > +		*val = test_readb(test_conf_space + where);
> > +	else if (size == 2)
> > +		*val = test_readw(test_conf_space + where);
> > +	else if (size == 4)
> > +		*val = test_readl(test_conf_space + where);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> 
> To handle cases where size might be a value other than {1, 2, 4}, would a
> switch statement with a default case be more robust here?

I was patterning based on pci_generic_config_read() and friends, but I
see that those use an 'else' for the last block, where I used an 'else
if'.

I suppose I could switch to 'else'. I'm not sure 'switch/case' is much
better.

> > +static int test_config_write(struct pci_bus *bus, unsigned int devfn, int where,
> > +			     int size, u32 val)
> > +{
> > +	if (PCI_SLOT(devfn) > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	if (where + size > TEST_CONF_SIZE)
> > +		return PCIBIOS_BUFFER_TOO_SMALL;
> > +
> > +	if (size == 1)
> > +		test_writeb(test_conf_space + where, val);
> > +	else if (size == 2)
> > +		test_writew(test_conf_space + where, val);
> > +	else if (size == 4)
> > +		test_writel(test_conf_space + where, val);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> 
> Same here.
> 
> > +static struct pci_dev *hook_device_early;
> > +static struct pci_dev *hook_device_header;
> > +static struct pci_dev *hook_device_final;
> > +static struct pci_dev *hook_device_enable;
> > +
> > +static void pci_fixup_early_hook(struct pci_dev *pdev)
> > +{
> > +	hook_device_early = pdev;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_early_hook);
> > [...]
> > +static int pci_fixup_test_init(struct kunit *test)
> > +{
> > +	hook_device_early = NULL;
> > +	hook_device_header = NULL;
> > +	hook_device_final = NULL;
> > +	hook_device_enable = NULL;
> > +
> > +	return 0;
> > +}
> 
> FWIW: if the probe is synchronous and the thread is the same task_struct,
> the module level variables can be eliminated by using:
> 
>     test->priv = kunit_kzalloc(...);
>     KUNIT_ASSERT_PTR_NE(...);
> 
> And in the hooks, kunit_get_current_test() returns the struct kunit *.

Ah, good suggestion, will give that a shot.

> > +static void pci_fixup_match_test(struct kunit *test)
> > +{
> > +	struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);
> 
> The common initialization code can be moved to pci_fixup_test_init().
> 
> > +	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
> > +
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
> > +	bridge->ops = &test_ops;
> 
> The `bridge` allocation can be moved to .init() too.
> 
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
> 
> Does it really need to check them?  They are just initialized by .init().

Probably not. I wrote these before there were multiple test cases and an
.init() function, and I didn't reconsider them afterward. And they'll be
especially pointless once these move into a kzalloc'd private structure.

Thanks for the suggestions.

Brian

