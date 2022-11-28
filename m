Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40AF63A6AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 12:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiK1LFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 06:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiK1LF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 06:05:26 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92164192A6;
        Mon, 28 Nov 2022 03:05:24 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D97545803D8;
        Mon, 28 Nov 2022 06:05:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 28 Nov 2022 06:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669633523; x=
        1669640723; bh=BN0GhcUCuc6Kbhxsw+Pvuo+MIowS4/NAxgbzxGS28lY=; b=N
        4VI1KdUXlGsPgEsCvyBFHW+MZ37GaxUI6lzE+jwB7yIlsBGi6Sh2Bsg0suQg4lmP
        nmF/Zqg2yG8VbDg38/jJ0pxf0RD3B6/esq9U/ywyHS+PChJ3a3xR1E5+8lpejxKv
        C0eXqOIXW0KSuxRG5ey3eKv9mIwbkm3wmtNcBcdv8p8V+a+eRZbgrms46spjy6gm
        c2CDqVoM2P5QOoVTTKTM7Z1RHNitCzOCTiX3/Pl5IXC/vilag6TmktOmBV56FrBw
        pbkMfHkboU7gUEE08JEpLSCDzZYpRqacZcckV/GiTQG00vOU8wqZDSIWUhBbyLqU
        +oiLo+je6ty7feN/oEzHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669633523; x=
        1669640723; bh=BN0GhcUCuc6Kbhxsw+Pvuo+MIowS4/NAxgbzxGS28lY=; b=n
        XYlnvkpP4AKpQiNhBOV5M+WN8a6kSBnWj1mOkQUZM8oi63crVX/2V4MxGP7Cvjwh
        seHKJyk1hlGJeRS5IvSKyG5uzg47TFK1GNcW3nT0NF0wkQ1KtuqEpL9LYhkBRFCS
        UsomFR5aPDTeSvFKr7jt1IXklGys4IOY2X6d3FbMKHn9Cfs7n71e/46Dl7HOqgir
        PoEsuZkOijBsx7IT/AsntH7E0UlH7JcjE7BS4xtWs8RMjk4OOw4249ufmNkfmrBb
        CAMggXwlMeqarPAAJGnNAgK444n3VDDbi5O0xulXe3qP6VSopckvb5ZnZNJFkFcs
        MzUMAz/lw2fjTu8ku+MIw==
X-ME-Sender: <xms:85WEY0ETm6arca3Hf2AZDglBsUut_rXSTz9A7ExfMHTT_xpsm35lPg>
    <xme:85WEY9W0NalDpUiI5f55Au61ryHo2erSA_QfovAbNqgCdyk3G0O-08pvUQ-t-6l2q
    9EJutmiZMWNX00WXOY>
X-ME-Received: <xmr:85WEY-K0Ea44QYLrKExUK6QVN9HbnyB89XNdZo0rW6WYTdONBAso36YpauS3IlytWKm0RCGASFNlrwwes2yyYoo0ZekYvcD93HRX3fH74d_dZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:85WEY2F8SAdYTA5Yxpi4ToRlXu8pGvUP2yF1xmTWj8_H3YPuRwXmoA>
    <xmx:85WEY6XfSz28hejieWrGmWfMABm2O3EM2Mu2ol-onsBQsOOwyL2Ylg>
    <xmx:85WEY5MTPwfHY7auQTUjOTFcfczxccrycpZzb4XWy7N1Oi1IIa3hsA>
    <xmx:85WEY00OX0Q46igfqU9mgdrohlsiLKFOKdP_dNlDV8jizBCyDQCpaQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 06:05:22 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        =?UTF-8?q?Ma=EF=BF=BD=EF=BF=BDra=20Canal?= <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: (subset) [PATCH 20/24] drm/vc4: crtc: Provide a CRTC name
Date:   Mon, 28 Nov 2022 12:05:01 +0100
Message-Id: <166963342298.56696.16356568683060608437.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123-rpi-kunit-tests-v1-20-051a0bb60a16@cerno.tech>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech> <20221123-rpi-kunit-tests-v1-20-051a0bb60a16@cerno.tech>
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

On Wed, 23 Nov 2022 16:26:02 +0100, Maxime Ripard wrote:
> It's fairly hard to figure out the instance of the CRTC affected by an
> atomic change using the default name.
> 
> Since we can provide our own to the CRTC initialization functions, let's
> do so to make the debugging sessions easier.
> 
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
