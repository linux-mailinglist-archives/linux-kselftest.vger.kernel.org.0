Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC063A69F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 12:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiK1LFW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 06:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiK1LFS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 06:05:18 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8B192A6;
        Mon, 28 Nov 2022 03:05:17 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 592BD5803D8;
        Mon, 28 Nov 2022 06:05:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 28 Nov 2022 06:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669633517; x=
        1669640717; bh=HGNA+mHj/3wrFiqggGiI6SdDBIAzNFhQQeizXQV556A=; b=j
        ZzauxK33nvq3erVwAHB0njU8/xBZnnc8GESS+FAEBR6Cb9aRJ5vhBtsF4+vyI0Yr
        ke4J0pa0mRPNGsdhc1vw2KX8ijgGgysOooB6+apBodZRDdNZOiu2awAhy/X7B5n4
        gBRyNpG5LbTrixNu+lBjmY1UuyTuPNSF/VxO6mmXbAbDOinO+tYVZ2NajF8b5GkV
        QujzpxBt1uu9JUoQqFf3ZYBmoZR5dUXtvC4ksgP6h8KBBKJeTrkLSmGmtGIqJbuT
        +Bciz/o4WFvlCv+rqfF4+cZ5B/r9l99ejbRB5eBdR7JKKsEtSye5o92KoJj8VKw8
        fKzzphXd5Cc/gPYX2EiYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669633517; x=
        1669640717; bh=HGNA+mHj/3wrFiqggGiI6SdDBIAzNFhQQeizXQV556A=; b=G
        zO358g8yyQw9DAqp3T3H1x95Yr21NxKCp1sIYaV6YNbwFM3KD3kUY217wciCvq4c
        FZ5okVG3IALaVU1HfnnLYVvOlN5lesKcsbmPQyyquWkxyDHz6IWUYRr5MAZCFDRJ
        xPcNSmGBQLF0HztzAcyX1XvsXWPOt37j8lRETIZ7Cvhx8a8zyHPuQUGsDCRYPbJE
        2u/MUGjNenATkuciYTzkKnWt1gQRYGoBhkiWO3jHptdHGBtQNEfLSJ1LR56ZJYU3
        5QdDezNaXOhR0yvNlAtuqco/Q32kzHL1hiAtm17YIaZjx8h9l80+1bhb+RK+fP+f
        oMtsr2SZDGxILP8IjHZnA==
X-ME-Sender: <xms:7ZWEY2vnqWWeXvWbG1JXXNDv2e-dSNnYFmKIEIcuQOCfkNsqXLox2g>
    <xme:7ZWEY7fG21cGPSDnExRidQaUU_JtxR_PozNZ8lRwhJP9lZR5OIebpGE9kyxwNg7z3
    55VgF4RsxxtXv7VvRI>
X-ME-Received: <xmr:7ZWEYxxeMLe6gSmb0ISFGA5KijO5Y6HnV4aC8e7mwcfPmpyL9SWhRU9B8OV8BH8plqyeQUu99GExfr6rB30YcgtNYzPlu0dWPv_1hxh1Xaf_-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7ZWEYxOm2MKVWIxZkI8GXQbUWAOy-rQeo_1hICgAzuPLTKHJQ7b7_A>
    <xmx:7ZWEY2-MO2sSY2_4dOataSSmsq8PjK9XxPepRLCGrexWcHG37FXnXA>
    <xmx:7ZWEY5UhwWHt4Gi0zTsP2KOdRelCpUxYIcjBruIx4rCifHdYAUw81g>
    <xmx:7ZWEY1eXGFji9Qx3taPTPvG-3kTbbM4x5XdCcIpyda1iR_77Rbxq9w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 06:05:16 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?q?Ma=EF=BF=BD=EF=BF=BDra=20Canal?= <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: (subset) [PATCH 15/24] drm/vc4: Add TXP encoder type
Date:   Mon, 28 Nov 2022 12:04:58 +0100
Message-Id: <166963342297.56696.9898276346017786478.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123-rpi-kunit-tests-v1-15-051a0bb60a16@cerno.tech>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech> <20221123-rpi-kunit-tests-v1-15-051a0bb60a16@cerno.tech>
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

On Wed, 23 Nov 2022 16:25:57 +0100, Maxime Ripard wrote:
> The TXP is integrated as a separate CRTC/Encoder/Connector combo, but
> for some reason doesn't rely on the vc4_encoder type and it's associated
> type.
> 
> Let's create a type to make it consistent with the other encoders.
> 
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
