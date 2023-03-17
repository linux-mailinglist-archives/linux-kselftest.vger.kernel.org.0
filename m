Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB686BE406
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 09:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjCQImQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCQImA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 04:42:00 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EDF1205F;
        Fri, 17 Mar 2023 01:40:37 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 40E4A2B06754;
        Fri, 17 Mar 2023 04:39:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 17 Mar 2023 04:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679042394; x=1679049594; bh=vd9YrYSnV4XdS8WGt7v2P7Vyy5NZXy01mXq
        mDhxZrBk=; b=J5Flu0OFGnWhvnczWVSoPOJKDUehhmBYZx8M1v7obqIpWIJlYUH
        PTGqbYbvMURhKg20tWtkTjMhVU1LLQYvtQYXrvKjT8PPF3gtmxkaGZaOxfv7pPOD
        sp8WKeQG279mQ7PBEAv8nHP3pBze/hfCKQTQt8Ad+KWT0yR6NxSdhsg12OjHY8rZ
        nqgJsXXSYojYL+QOoIJ/qh4rQ9Uiehgrmfn57ZcUalByr1EDyh/0erX9LFx0PRM7
        MTWb5wTQ8ZO/42AyMIQL1X4ybU7liD7d1ApxE/WXqeLq6R1mNofBg3ukeJYn+9YU
        tbiOpECuDKPBgPzexnLmrCUcGTPEDGVSsJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679042394; x=1679049594; bh=vd9YrYSnV4XdS8WGt7v2P7Vyy5NZXy01mXq
        mDhxZrBk=; b=KqtwJZjwVnUe5XBlxTwzUKQNXyC3Rfsei1gmTYeUHmfumN9D6xG
        09uK5EKqNS+BBcRqEe5TaalMgM1TqLZZssOtpMDrCuJTu5rA9H1JBAFNTk/1AuLe
        sIE0ZzNC14+F1kvMpLuhD6yimW4RlLH8dtvEHYQL3wiHN/E0LTpCpAZjzWm39089
        nQY+ydpKmPpU69PFkZGUruBLAUFvrROZT8Abkv/joe4n5TgVzExbwEHiNzmpTuQf
        p+ScDFBOpLur5LwyhJPMsr0oE5KtukTw1bX5nsjTvvGOvS1chYho8w6vo3ptoTpm
        cFbOdQ9AWm7hg4GgCsvc1FgRFNWNNPed0MQ==
X-ME-Sender: <xms:WicUZHLilA8zXpe5Xb1fj3MjTT_oK8DCnUE9GCcRjRDnvbCzy72yzw>
    <xme:WicUZLLy5EqEHolQ1oAGq-md_oHg6x8Xf1cgdYuR0QByrIHTaABMu5m15uAq0Z1fr
    ZL4nQfj41mAGsNHkCE>
X-ME-Received: <xmr:WicUZPuZ_6TZ6oGcbxdPMMxZzZkoDNHiCj8S5ax3eVW2TnOQHs5nbHJfsb4SFfn7bzXNCkDLHmQwTa_ZVhf_N-_T6kO8Q-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeeitdeuffevieeufedtuddvffffffegfffgkeeihfelleektdelhfev
    hfduudfhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordht
    vggthh
X-ME-Proxy: <xmx:WicUZAZ-c8e0fPKAOsp-qMCsIOlSrT-zVWG5n-P4NsktYNrXKJEPmw>
    <xmx:WicUZObQMU2D5jvplwyUvdeuBpE28F4Zgi4VUi1Y21G_AssogWcU6A>
    <xmx:WicUZEAy0yj0Eg9FZp8z1DN3HQkMUEb9imJ_jeUciBfXTU0CXo0epw>
    <xmx:WicUZBldN-2lwA1IiSkG-EhWzd4we2dkvC2wdt2HqTupC5jE7QPPL-pnr1E>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 04:39:53 -0400 (EDT)
Date:   Fri, 17 Mar 2023 09:39:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 00/11] clk: Add kunit tests for fixed rate and parent
 data
Message-ID: <20230317083951.oaupqybf7llrpmeo@houat>
References: <20230315183729.2376178-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230315183729.2376178-1-sboyd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Wed, Mar 15, 2023 at 11:37:17AM -0700, Stephen Boyd wrote:
> This patch series adds unit tests for the clk fixed rate basic type and
> the clk registration functions that use struct clk_parent_data. To get
> there, we add support for loading device tree overlays onto the live DTB
> along with probing platform drivers to bind to device nodes in the
> overlays. With this series, we're able to exercise some of the code in
> the common clk framework that uses devicetree lookups to find parents
> and the fixed rate clk code that scans device tree directly and creates
> clks. Please review.
>=20
> I Cced everyone to all the patches so they get the full context. I'm
> hoping I can take the whole pile through the clk tree as they almost all
> depend on each other.
>=20
> Changes from v1 (https://lore.kernel.org/r/20230302013822.1808711-1-sboyd=
@kernel.org):
>  * Don't depend on UML, use unittest data approach to attach nodes
>  * Introduce overlay loading API for KUnit
>  * Move platform_device KUnit code to drivers/base/test
>  * Use #define macros for constants shared between unit tests and
>    overlays
>  * Settle on "test" as a vendor prefix
>  * Make KUnit wrappers have "_kunit" postfix

Maybe I'm overthinking this, but wouldn't it make more sense to have a
kunit *prefix* to those functions? Any other function in the kernel
taking a kunit test pointer as a parameter starts with kunit (like
kunit_kzalloc), so it would make more sense to me that kunit-related clk
functions follow the same pattern.

Maxime
