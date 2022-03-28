Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC644E8F89
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiC1H75 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 03:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiC1H74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 03:59:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E62E2;
        Mon, 28 Mar 2022 00:58:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9843C3200D98;
        Mon, 28 Mar 2022 03:58:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 28 Mar 2022 03:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=QUhetPbcMZ4GRs084KnJjbC3B93vwFaeLGCDiV
        JCavw=; b=lalOpNi1+0jDPoPX+Lpg+or6w3q0+yiPz0d/QxAP4KXmaGDu+h0OY0
        AjgC8eRICW8ZqvnRrbOPp3rzFRQD5uauw9JN/CnZ4FF97icHy7ryOae6gewr3UAT
        zrLODxWgHlanr3Jztw93uMmdlhC07ci74bp2/BmnZUFO9mIjt/47LnCSuvxzMJQw
        768KF7VvEjx1wkZER9gqLy9Oiqlq1tUauE2/0HMdQKEis6wHMw3wfLOIBxe9HK+g
        Z2y8A50SXya8tfGw8yNOwZN6WLjTfqEiaOH4i6y5fclIk165JHzSvXKQGUCrauqm
        mXfcf2mj102G4QzFr5Yvw0O67Vw3/ZWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QUhetPbcMZ4GRs084
        KnJjbC3B93vwFaeLGCDiVJCavw=; b=HH5VjlICmcYLKLLOUG7gLY/mCn/81g3cI
        veYCuu2awG0Hu3jfOuhjMcQx+vLmPCihegc/Oa4BmBduFrp83rbyIm0NnC2ndYDd
        iLrMMrRtsIVUIPQVu4lEozqcwTej5ISSWaY86rq8oYeiZL58ZahdBzlJwzL9QvsD
        pCSo1FDrmB0moDz5fK1iW0jlp6dzm1v4KVYcjFGY32X7rD165zxciXF6+6ssDEuF
        D1SoZ9AQba1qdVNFkWB/M6lWfvYMPWg5bi27ayD0+81Xq6TwDTDlcyznQFYuaY6l
        g8ExVDmibt/jUt+hPhsdeXwqNWuYGPx5T3cFUigzhBZy7vr3OJ3CQ==
X-ME-Sender: <xms:lmpBYkcOPCocBOneEvIydyTu5dJnP9gV0R1uPOUHOdgLSE0KIbTRpg>
    <xme:lmpBYmP6z_PN-0jNSVlmJepjnCGkxk0VYI-H7CIciy3yipJpHoH4ZIlXgqot4Fhs4
    zP5MXi_g3DDM87QXks>
X-ME-Received: <xmr:lmpBYljmJk8C9we4FD6gtrI0XYnLVBMgBwuEzKunr4rHTFxUjGyZc61HquEojo-Ps321qnfWKYPEaloKTjpde0kWbjqgPkKKsJu68rk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehiedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:lmpBYp-PhpSFp5lTKcIAjuwV2pk5XoAm_5W3YSZME1BPrYBRlleEBw>
    <xmx:lmpBYgvFK6cqpfohnxRvbFQdz5bm9TArOBzYUQU8hkwTgYmoBMj7RQ>
    <xmx:lmpBYgFktTFxMyZ3ByzYPyUZFu0LUYc0j9fcWJyUs_qaGrf74SYe7w>
    <xmx:lmpBYkiT9fRE66fFL8lm-BvjDnFmIDnn_3TO5vYQTGNyN9i2C8YJ3w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 03:58:13 -0400 (EDT)
Date:   Mon, 28 Mar 2022 09:58:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
Message-ID: <20220328075812.edzufjsxzzwbetlt@houat>
References: <20220326003356.487828-1-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppcou6d3vfphxxd3"
Content-Disposition: inline
In-Reply-To: <20220326003356.487828-1-dlatypov@google.com>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ppcou6d3vfphxxd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 05:33:56PM -0700, Daniel Latypov wrote:
> Recent changes have made it so the current set is not sufficient.
> Namely, CONFIG_DEBUG_INFO is not being set even when explicitly asked.
>=20
> Specifying a version of the debug info fixes this.
> Pick CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as an option that's
> hopefully less fragile (esp. given we're tied to GCC 6 and lower).
>=20
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--ppcou6d3vfphxxd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYkFqlAAKCRDj7w1vZxhR
xYqxAQCzjp6odcEDwIP/Kttn+D/52lKDsCBktrtAgPd+HWN4cQEAr0XiTXj3gPBF
VgIXK8fvMIhMlsq6/Qah+KeR0wS91Q8=
=qzzD
-----END PGP SIGNATURE-----

--ppcou6d3vfphxxd3--
