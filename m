Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A541963A691
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 12:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiK1LFL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 06:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiK1LFK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 06:05:10 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC3E1839A;
        Mon, 28 Nov 2022 03:05:09 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C39835803D4;
        Mon, 28 Nov 2022 06:05:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 28 Nov 2022 06:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669633506; x=
        1669640706; bh=WRPoxqvq1slaZ94whCa6Kp30ZmhMsSXuWCZ/P62/9u4=; b=N
        KyQd8EEmYfyqxuGSm+JxAzjwvTwk79Hg5Drb3hRh0eGmoA5MvmRObQIgjOz9uEZj
        Mh7VBQ5XspvmnWxEi9EeWVNbPBekxRqpBa2v+VWAutxc9Bb2SLfOc9A4eQBa7DjO
        /RazSAeJgEOtyCoI4q3nCtl3czfhW2w9y0Q7NC1kFbKsEvWcmaSgSY2h97QjhDKj
        s4JOTwE3Kefy3cAZWmTQb1slyjzEmQNYt4wln++lK5PGapGAIqdDdz7MoDUDyPfy
        vBeI9nvIu4aS+kaOHa4Ahh0E9/YXIzjj/uQxA5+HvyXf3sgohEHKgd2B9Iis2z5l
        EWSwM3m61zO+tUO80FLpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669633506; x=
        1669640706; bh=WRPoxqvq1slaZ94whCa6Kp30ZmhMsSXuWCZ/P62/9u4=; b=h
        UrX/JhfEsnC0G0ObofMPEW9u3ZHDUw2RDPJXmqPh9f1FzHTR6qQc3pdQyHLQH/Na
        MdIZR0Sqd23hGb87vkgAZW+ws8S1cFdxJpNRg83usMK3TlalM5AkUsGKAiFjv1We
        DTsr7ftsgdboYosASgTx0cZE7X56Kc6wz0jnOoWDB3+xKQxRXI1LApnlne8BkFof
        9qzHOVOFY9YLeqxCfvEXMA/2BK8KF775iFEnjW/ppdSA/BVfBtbVgrwPiLoUjiAn
        Ei2XCsqBiHH1WGkFAlX9HvmeyUajw+F0NeShDqQmYCn2XpakjYbKIokVGL35LeXA
        C14jT05GaxXw0mpsqZ6XA==
X-ME-Sender: <xms:4ZWEYydJUvuclFXdOmuf2CCopFyVAz9R8ZC_yXSNAlf906BMsysREA>
    <xme:4ZWEY8NLrHmKR1gMvW6nS8-fQqxVHG_DyHg9sQJeR3M9LZiQ3Hmg0eQvJKbZPhldu
    a-Pj1MNHvN1m5PUEcw>
X-ME-Received: <xmr:4ZWEYzjMkYPTgFEA5Phf-3C03DJ_EBZGEm9Qw4423_N9lTCJ_JL9CVb2U1GGgYhc7ByN4JgGku3rMSxyrI742iGBA8ud-K_GKGSHkn30izNNhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4pWEY_-vERustfYa2ipeEXJDgbiL17hI5LNNM9Pio_tWB4pT58aOKQ>
    <xmx:4pWEY-vN_gf4YAkzE30rwy9J1qgX-JhvE4W4ZMn-QpAfHWR2PcKxNw>
    <xmx:4pWEY2FrCXTx9wx-Cev3C4f9_zVPpzaSas-U5Qf-54qS9LlcldkeYA>
    <xmx:4pWEY1M6BppK9qF-csh24VqpPHvJ5QRR_x_z0hUZqLLQXujxleCRFg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 06:05:05 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?q?Ma=EF=BF=BD=EF=BF=BDra=20Canal?= <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: (subset) [PATCH 09/24] drm/atomic: Constify the old/new state accessors
Date:   Mon, 28 Nov 2022 12:04:53 +0100
Message-Id: <166963342297.56696.37811222160355559.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123-rpi-kunit-tests-v1-9-051a0bb60a16@cerno.tech>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech> <20221123-rpi-kunit-tests-v1-9-051a0bb60a16@cerno.tech>
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

On Wed, 23 Nov 2022 16:25:51 +0100, Maxime Ripard wrote:
> The drm_atomic_get_(old|new)_*_state don't modify the passed
> drm_atomic_state, so we can make it const.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
