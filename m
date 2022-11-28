Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4363A694
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 12:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiK1LFO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 06:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiK1LFM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 06:05:12 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80EF1900D;
        Mon, 28 Nov 2022 03:05:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 42FBF5803DA;
        Mon, 28 Nov 2022 06:05:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 28 Nov 2022 06:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669633511; x=
        1669640711; bh=n7MXFL9CidPfBtwAJuLJLGulzgpAqtA68nQIGwSX5U0=; b=Y
        LhvGaoW+idR9a0NMekJf3035vwPAzcTE0qbgvcqtju0C2Y7RqPCbPcWMn8HxAb3h
        WgAQtCjnLWbPOIw/55j6BP1Jnl61HT8spx1G5ixDXwexWpRGaBvH665tUiXoLb6v
        QyCMmO/wdGygZnsw+M/Mrt7iIQyPpA7jcZQTDW0sx5/Oyl0nCPBYDaw3Ugu/eSfK
        r+vra/2owmHvWeX0gIj1drk//+5wAQVLZLtnQ/cInByRdKW+mQVMBjEcWqNfpbxS
        f+0Xm2hPw2fcD/FIoUsz4DpYnD7EVM1yDiTinmJn4WhVK8//weVaTWVGbqueKIt2
        ZZK48JPSFYPE4dhe9krfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669633511; x=
        1669640711; bh=n7MXFL9CidPfBtwAJuLJLGulzgpAqtA68nQIGwSX5U0=; b=l
        kURNatGt/+nUJY6JCHV/dLWlrqmdPO1uj8vGG8bj7EgElGirj8zxWdbmJ7Hj5YwB
        uG9MvDDW2Si4/NdZ3Ldra2i5i6AsE32MwB8KaRZfhxy0CIYFG7dsPmIcfcB+Y/Rx
        XeTfc5+9zwTeJlJaZ44Qcon40vFcRL6sAjTuDsNhuhR2mty/Dl42cqu3ErZBlMEP
        iBEF+Xi+vEfxyP6dCbo7+im6MrbkCRnOYnTWLYcStt/MXLtcdfXa0zmEC/3+dHdk
        /yQDTWxv1xydgXYYgwr+BDDloUGKwfU4LtA4R9C8TQhfDoUgWouhSEMJsVt+s48v
        S6JwCUQe9Flkf4ItWtwtQ==
X-ME-Sender: <xms:55WEY1RAQA0p-YRenusxfENmGOsaiAbJO0izM13zDUbwpJ2cAIDi4w>
    <xme:55WEY-z3jMuJzM0SnrOeFYjmI8dN-nk6EOUdPWFBKUtzm42LdI0DggsbhuY6hvzYU
    Na8k8470JCbFJfOn0E>
X-ME-Received: <xmr:55WEY63vs37113DYZ4A1totcpBt2wnnGHvUGcIDjDHydJkwRTtDQSuVoH4eTtUPgsmdyNGUyg1cJXVCuOBtjw2A6Nqlcn1Qh4JsqvBQBf-sJ5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:55WEY9DmUdplkV_omtyXS_HCDtURWgL02-0BjmqLVXgJaG7b0kvnbw>
    <xmx:55WEY-jqQe7cf-cBWrHVsLWNWqbfK0iXBh20QJ7OSZyOB2tou_PC6g>
    <xmx:55WEYxoR5Omz3Mo-gga9VOGGjMWbZIrCgkex48dnY0Wa61JMqWpD5A>
    <xmx:55WEY3AsgD_JGCj3YT3gRi4a-C9X_panRLzaqbQMsVkSSZ0P6GqaLQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 06:05:10 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linaro-mm-sig@lists.linaro.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>, linux-media@vger.kernel.org,
        =?UTF-8?q?Ma=EF=BF=BD=EF=BF=BDra=20Canal?= <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: (subset) [PATCH 11/24] drm/vc4: Constify container_of wrappers
Date:   Mon, 28 Nov 2022 12:04:55 +0100
Message-Id: <166963342297.56696.14557106661575377639.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123-rpi-kunit-tests-v1-11-051a0bb60a16@cerno.tech>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech> <20221123-rpi-kunit-tests-v1-11-051a0bb60a16@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Nov 2022 16:25:53 +0100, Maxime Ripard wrote:
> None of our wrappers around container_of to access our objects from the
> DRM object pointer actually modify the latter.
> 
> Let's make them const.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
