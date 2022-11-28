Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42E63A6A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 12:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiK1LF0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 06:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiK1LFV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 06:05:21 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0B193CF;
        Mon, 28 Nov 2022 03:05:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7E6815803D8;
        Mon, 28 Nov 2022 06:05:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 28 Nov 2022 06:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669633519; x=
        1669640719; bh=iBPrSVFAFsgtvDN1oy2ObGoqar4ThwUCtePKmIE8jEE=; b=V
        fBDtmzq/0uO9A63pEtvJFOSvUCmWPNz6ZGN3hMMOWgdGk5mWNOXtRYWKFfFvz0ST
        0aob+k9/WZ4MAfHj7oMddj6yZQ+tMrT6FMneeAGPsdkR+YEvfjEFx3QTjek/DcXt
        /h9epo9Pr3zaaphoL+k4xtq9j6oRWlTPX6OovQjEBVN4qlysuwCbLi2bCTECgwuJ
        TFz/tZ4i3WM9vl1keQBfHEf2Lf6GrQOAWG4BYEGDulP8aiPQAVL92RNhjqBkXVl8
        AimtjCKWTrrebpG843TyRN0wpAOlqQBbfz9qGhzXFPkCVtvWA0UcTObgS3plAVHp
        D7HakpbyFQ8iCappgTSiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669633519; x=
        1669640719; bh=iBPrSVFAFsgtvDN1oy2ObGoqar4ThwUCtePKmIE8jEE=; b=E
        +lleZZiSunrHqGvmz/ZLI4R1U3h40tpGkpmGdplVoaUSrSFUEh89EkretORqHsbY
        nS49++cBa1z2X1KtHSs6BR2uNB7KK/t2LC+elSdKkGXVGRw1myociGMhjs0hbrbc
        Mc2+oRPth1NnObyzsY+uCal/ugawOBTAcmXZJ+0012pWMsEwgcLjeyzD9znD+Ja1
        Aa4x0C6jGkyCl0oEpjK3ipB0TjUSX2anG09NnNQF4ugKzZ+0bQNoEA1L3FVqY7CF
        tg3aH/gUlfmAYCYgkXhyLJr/QikPD1AANKsFeesEbRJLtBhdtNvAGY+5LqnL5qce
        I386h/AAEVKJkmQT/RHeQ==
X-ME-Sender: <xms:75WEYyZg43DvXLHryKVPXajPD84nl0zM8C3VrE6fBa32Id-Rr5vVNg>
    <xme:75WEY1YwMDivzZt_pu9IavOhTHXYjA9605KHTVVcxI0bsmgbAlQrT4D68ZtShyYxV
    N1h08A6BiJBarhtNMU>
X-ME-Received: <xmr:75WEY88wmlKUaT2GVKmeqBkCO1CS4s6P-_Fg9SFshXMUamtzkbFMWS-tJyW35XJwjcqcz_MOYqIneYSX8x26RRdAleDQUSiiGxwxJDvOuoa3iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:75WEY0ouOHk3Fx3qasYwdPYtr7v6t1ZnXJs66BTbUjRu9zO4uK8Sgg>
    <xmx:75WEY9r1_SosKzuNa0WcUZ3DPVcaa3Si5xYE39m_vTBGgPbNUqfJPg>
    <xmx:75WEYyQm4qq9-CJYyVgWqdJFo-ui4bBpHTVx6x5T4FEQsOqjSiq8-w>
    <xmx:75WEY6Jk-Rr5Vk_H0vnh0qZ6IKaKBJ132B70LwMQjm0VWLAzRr3oJg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 06:05:18 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        =?UTF-8?q?Ma=EF=BF=BD=EF=BF=BDra=20Canal?= <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: (subset) [PATCH 16/24] drm/vc4: txp: Initialise the CRTC before the encoder and connector
Date:   Mon, 28 Nov 2022 12:04:59 +0100
Message-Id: <166963342298.56696.9364312621338205407.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123-rpi-kunit-tests-v1-16-051a0bb60a16@cerno.tech>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech> <20221123-rpi-kunit-tests-v1-16-051a0bb60a16@cerno.tech>
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

On Wed, 23 Nov 2022 16:25:58 +0100, Maxime Ripard wrote:
> It makes more sense to register the CRTC before the encoder and
> connectors, so let's move our call around.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
