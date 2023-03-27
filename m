Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F127D6CA694
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC0N6B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjC0N57 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 09:57:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE911711;
        Mon, 27 Mar 2023 06:57:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C499E320092C;
        Mon, 27 Mar 2023 09:57:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 Mar 2023 09:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679925476; x=1680011876; bh=xGJXbEhrl91uNM1/D3zlzsQqHed5bWXL+CG
        9EThtPTA=; b=U8nVqssP+oT54AqwEyOYS5gWpuGWPxYnrmh5eZ00saX4Vs7z4ST
        VP0hCQWthFZr0Kfz91iBon6mUqJ8bfLXVQhiRHDrlnn2L8l0ECIQlJCUjeqLO2ea
        XE8RRjfPjnS2HJzbb5mbMg4CNKFvfJMD+7k/Np1PFKpBAGNxNN7PsseQryKtpfAN
        EI3XJ3NX14fS7cxuXFOmW79xuwtlPOnLKF0q/JoRIPSsRHdiuedleXp3EIyU9jI5
        Suv9WXxMTtiH2nqzisaxSJxWhghP02Qc0eEPnCC6I0I1gvFZBT2RwrYIpBqBNefG
        yu4m5ALvym9vjc/sLpEqeQJpA7bHdXRNpsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679925476; x=1680011876; bh=xGJXbEhrl91uNM1/D3zlzsQqHed5bWXL+CG
        9EThtPTA=; b=kAh+8Dej35XHTK1kFnCco+p2tcyw65wsi9Yu9ahSbXsvIAAIHAW
        vtV70adwEs1B418lpm8/L9Y+jMTTpeimrZdnWo+YBWPT0+2RhfhuDOeOx/CUgX2m
        tE8act0TL4Yp88jQBfT1lG7HkpDdmzB3NY3VhTXfRDKd3ApQkSUG1kYezt9mZQ05
        9B6/EtBCYjgeg3EZy4j6SapfncAwufTOneSmgN5CwenXqoKxuEUbms/LreFlaYvR
        4RAJOSUS6zV28DHBXc8fr7hODI88bktVx02sPJnYu/K1XkmBiUUSwbkDWxUE15hm
        TUi2lBvDc9IfGkm1JS7Z24j+tVHdpQ14ZXg==
X-ME-Sender: <xms:46AhZCFdoW1blfH_RYR-zych5Rk1ITCNpKKaowCqdQwdtec6Wt-bew>
    <xme:46AhZDVpwmcSwu1KEX_XfD4b6xGMT0KEo2wkxJ1v2KLG4wjWegLBuZPwToWHrlgiL
    y9z4GLu8pC_jgDVLBA>
X-ME-Received: <xmr:46AhZMLBiMKKJR-lG52l8P_Kb9MrF7pnp4kEW-NVf2nghJQ7epapYAiyCq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptefgleeggfegkeekgffgleduieduffejffegveevkeejudektdduueet
    feetfefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:46AhZME3CtI0dCjyrJqvX6hHQUIlbrHGakrAFMnyKMvwvBoC0a5fzw>
    <xmx:46AhZIXnoJy6hvq-0FEdl_o6mk-9zYtfhhskUc5kuMMg0o8o74RL8w>
    <xmx:46AhZPOtBobpcnYqBe5i-f5fMsK8PPzFDxBVB-070mOmadDJXsXF6Q>
    <xmx:5KAhZHMjwEV-Y9-dT1948Mz3chxQxHsASJrqrMGJzvxKlJCFSqLKOA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 09:57:55 -0400 (EDT)
Date:   Mon, 27 Mar 2023 15:57:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [RFC PATCH 2/2] kunit: Add APIs for managing devices
Message-ID: <20230327135754.tadvfirhixbhatxy@penduick>
References: <20230325043104.3761770-1-davidgow@google.com>
 <20230325043104.3761770-3-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230325043104.3761770-3-davidgow@google.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Sat, Mar 25, 2023 at 12:31:04PM +0800, David Gow wrote:
> Tests for drivers often require a struct device to pass to other
> functions. While it's possible to create these with
> root_device_register(), or to use something like a platform device, this
> is both a misuse of those APIs, and can be difficult to clean up after,
> for example, a failed assertion.
>=20
> Add two KUnit-specific functions for registering and unregistering a
> struct device:
> - kunit_device_register()
> - kunit_device_unregister()

If kunit_device_register() registers an action to clean up after the
test has ran, I'm not sure why do we need kunit_device_unregister()

I guess the typical test would just call kunit_device_register() and
be done with it, right?

Maxime
