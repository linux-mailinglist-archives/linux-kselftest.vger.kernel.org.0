Return-Path: <linux-kselftest+bounces-41462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B764B57289
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7C51A209ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3282E9EC7;
	Mon, 15 Sep 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFDCJBL2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDD01D416E;
	Mon, 15 Sep 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923598; cv=none; b=ugo9v98jj5sKpJZGIjlzQsNckgP8NcgWxahLhTa3Xq95PSAX1SQI3I1CFr7z1CI9VK3/JPfqedV5UV8UJZOufJSHxggidT91XrfxQMl9LvwDjfNY0jraKGYBfyp13H8PcOJ0ew6RExT55u4dMcfl48gFLceS5n3aBHBEvMzhNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923598; c=relaxed/simple;
	bh=1wtoA59twXmHaJUE/DPZC+HVwZM8n7QOgu/PpOSxhro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c48HNzZWz5ALq7O892xbbrMwyWMO4ejsvB5aAuZayR/QSl1NYkAm1FrgsKjSL75AhRj1bEGNIVvLp98MnWv/pL2OnkM8t82ypMZ/b/jl+p4CxD+hoUV6qo0aL0zn/2h1X/9RTXsB0WTr+q8zP30+o8rvMMzH3u7FM+XZazMIwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFDCJBL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8173AC4CEF9;
	Mon, 15 Sep 2025 08:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757923598;
	bh=1wtoA59twXmHaJUE/DPZC+HVwZM8n7QOgu/PpOSxhro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFDCJBL25hLGW+aRNeMA+Kjfwz+tX7+iwODS3z6mBS7kPxMyCeKLsZg/Sloup2gd5
	 F/5je3AOCvlIpUmFIuPwDwI7RC3qTBujKCEvrFYCOSQizVh13YbcQ4FLsgW1hyDMJn
	 xFBJ1L8MMWQeIIJ5xbfgIrFCNZAfyQf6db6DEB+V1gLGQP+4fUpNcSUel/mb48gsLP
	 fyl3bB+R8DqBD0+M2j6fA2+a7uGQyD4kocprnZF47rbtm2UA+WJQLipnxUF479eOVY
	 8KrQCAKvcNkxOBZuavdjNLEoThjCJcD/4Axrd8xSax+2gfav7W/d8pTDt/wZYUsDZf
	 YUO92zreZF9CQ==
Date: Mon, 15 Sep 2025 08:06:33 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Brian Norris <briannorris@chromium.org>
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
Message-ID: <aMfJCbld_TMHPTbD@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912230208.967129-3-briannorris@chromium.org>

On Fri, Sep 12, 2025 at 03:59:33PM -0700, Brian Norris wrote:
> +static int test_config_read(struct pci_bus *bus, unsigned int devfn, int where,
> +			    int size, u32 *val)
> +{
> +	if (PCI_SLOT(devfn) > 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (where + size > TEST_CONF_SIZE)
> +		return PCIBIOS_BUFFER_TOO_SMALL;
> +
> +	if (size == 1)
> +		*val = test_readb(test_conf_space + where);
> +	else if (size == 2)
> +		*val = test_readw(test_conf_space + where);
> +	else if (size == 4)
> +		*val = test_readl(test_conf_space + where);
> +
> +	return PCIBIOS_SUCCESSFUL;

To handle cases where size might be a value other than {1, 2, 4}, would a
switch statement with a default case be more robust here?

> +static int test_config_write(struct pci_bus *bus, unsigned int devfn, int where,
> +			     int size, u32 val)
> +{
> +	if (PCI_SLOT(devfn) > 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (where + size > TEST_CONF_SIZE)
> +		return PCIBIOS_BUFFER_TOO_SMALL;
> +
> +	if (size == 1)
> +		test_writeb(test_conf_space + where, val);
> +	else if (size == 2)
> +		test_writew(test_conf_space + where, val);
> +	else if (size == 4)
> +		test_writel(test_conf_space + where, val);
> +
> +	return PCIBIOS_SUCCESSFUL;

Same here.

> +static struct pci_dev *hook_device_early;
> +static struct pci_dev *hook_device_header;
> +static struct pci_dev *hook_device_final;
> +static struct pci_dev *hook_device_enable;
> +
> +static void pci_fixup_early_hook(struct pci_dev *pdev)
> +{
> +	hook_device_early = pdev;
> +}
> +DECLARE_PCI_FIXUP_EARLY(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_early_hook);
> [...]
> +static int pci_fixup_test_init(struct kunit *test)
> +{
> +	hook_device_early = NULL;
> +	hook_device_header = NULL;
> +	hook_device_final = NULL;
> +	hook_device_enable = NULL;
> +
> +	return 0;
> +}

FWIW: if the probe is synchronous and the thread is the same task_struct,
the module level variables can be eliminated by using:

    test->priv = kunit_kzalloc(...);
    KUNIT_ASSERT_PTR_NE(...);

And in the hooks, kunit_get_current_test() returns the struct kunit *.

> +static void pci_fixup_match_test(struct kunit *test)
> +{
> +	struct device *dev = kunit_device_register(test, DEVICE_NAME);
> +
> +	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> +
> +	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
> +	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);

The common initialization code can be moved to pci_fixup_test_init().

> +	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
> +
> +	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
> +	bridge->ops = &test_ops;

The `bridge` allocation can be moved to .init() too.

> +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
> +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
> +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
> +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);

Does it really need to check them?  They are just initialized by .init().

