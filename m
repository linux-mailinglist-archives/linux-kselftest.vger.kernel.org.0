Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB58538019C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhENB5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 21:57:25 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57523 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232197AbhENB5Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 21:57:24 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B07A1580E97;
        Thu, 13 May 2021 21:56:13 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 13 May 2021 21:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=yu5svNfn1bqCNsbfoBd3B8VenMeM5wJ
        vXsoRZy33RJA=; b=sRiS9No7laMnkVWC+PL33B3RejcHw8dL1u+8PUJScroHf9E
        k4Zc3xUR2/uFRcyg9N4igSn5oTjwFqRFsODDNVb/6wmCdBGC+gJXcttsUairUKee
        Vu6ut2MCxjMcdEStGsHIUsXh2C0A/RT1KXXyJ4UCj2ACdYtloDorAyEC9S23L5cm
        51WAfxEqU1oVM8SJo+uYPge+L4Emv8R8mRgtdYgkHXjx+Quu2c2odiUo9tT9zEz7
        IYmx9hnWgTxbIuyo3fkUa0BGoc2H6tn+DV8jedlDoqqdWmJfgFEYNJUpyH09RiqF
        MdfOoTvh03DqychHNsVm4yvSv+dTWmqiTS/CXyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yu5svN
        fn1bqCNsbfoBd3B8VenMeM5wJvXsoRZy33RJA=; b=RBOXLkE9mJ0hLWvdDFSgel
        R0zOLc438Kpj8pRr5xuCIl0RtMLExMP7uBvf1ogUi1RTl4pR5OOMD/QBwaFcpa4x
        xHWXcSv01ZWniDgNkdGoI9z+P2UkP4j+GeNzRN/5Mc/Hqm0PJdY2H+DWP2VxkX6h
        4ctlcciTV1/73nUfBBLQc0TSaMB1zBkb+9L8GBJGlrZTUy575pPt3Ff0bQaGJyXD
        k8/xiq62Jvp+8i1e7jEB//9foQPYEZ+30mPHoHOex3gEB33PuICBndPnJZ5bnW/P
        kz9I4oW+gYQbgUKrc4S5NLhzKc5eBnlmoELlTqv5ceEzoiDl6OnS8oXgJ0MVi//Q
        ==
X-ME-Sender: <xms:vNidYD6BrVjO_32DFMfMIivyLKxZAbcI1HuG3QlC3WP6Dks279E_Xg>
    <xme:vNidYI7XG9Wt7Cq6TMhfTqTlY33ohwDCtz9zBpYn6L3tzk0rLfhgBoOag_aH1ACkk
    PufarDMWYKDQjahUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:vNidYKezzJIYiAZoVPdgRscAUA0MC0PWtN6oMRmU5m5a4M1Z0Hk1WA>
    <xmx:vNidYEL0Zx-HTb5zDmJ7oPF_7up0mZCNaW-ewcEXGnhvDFFwNQ-heg>
    <xmx:vNidYHIQ0mnaQjVVJBvmBFrSfLELjySORBi9dmw3iuVQgvRDqEWD2A>
    <xmx:vdidYJwKEEuhRERg2Et6jkBZsQx1cRKEtvEL5yWhXGhBiRHLgfJK3g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7EBCAA00079; Thu, 13 May 2021 21:56:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <24e8c5e8-d1eb-4e42-b8de-c60c5cceaf85@www.fastmail.com>
In-Reply-To: <20210513193204.816681-6-davidgow@google.com>
References: <20210513193204.816681-1-davidgow@google.com>
 <20210513193204.816681-6-davidgow@google.com>
Date:   Fri, 14 May 2021 11:25:51 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "David Gow" <davidgow@google.com>,
        "Brendan Higgins" <brendanhiggins@google.com>,
        "Daniel Latypov" <dlatypov@google.com>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_06/10]_mmc:_sdhci-of-aspeed:_Remove_some_unneces?=
 =?UTF-8?Q?sary_casts_from_KUnit_tests?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On Fri, 14 May 2021, at 05:02, David Gow wrote:
> With KUnit's EXPECT macros no longer typechecking arguments as strictly,
> get rid of a number of now unnecessary casts.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> This should be a no-op functionality wise, and while it depends on the
> first couple of patches in this series, it's otherwise independent from
> the others. I think this makes the test more readable, but if you
> particularly dislike it, I'm happy to drop it.

No, happy to have that cleaned up.

Thanks David.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
