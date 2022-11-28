Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388F763A692
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 12:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiK1LFM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 06:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiK1LFK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 06:05:10 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88AE1900D;
        Mon, 28 Nov 2022 03:05:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 48CBF5803D8;
        Mon, 28 Nov 2022 06:05:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 28 Nov 2022 06:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669633509; x=
        1669640709; bh=9KW+v1Zm5o9jjtnNYe44GqrcuqH32RH+LlZRtrF9EjQ=; b=S
        zoy7dCAbEgNDEoprk0rxTCle5W8dBL+z+rgWZBVCTk+sxJC78+AO5cXciRIkKswK
        y44AJlhRGG0VCxXd4bDql4i43YVW0iRCy3CbGJBG0ij8MoKqO052fbNoBAKmEriH
        FVSJa/O8qNbAOhtCswoJIfyDxy4vONgyPy4jzZ6cWu4uKWkrWWLNmMSKtJII4YzM
        az8EcxBjsXTDU3kD8wKLwKJBoHXdvhX67oCAVCpeJmmrq6Q5U4NGRabUm763U73n
        xmAWrgj2VNT2IAuX2nX1P+oJ1P139pJldzq5aP3ycrNwT1EigB5Xr8WozGlWNExu
        dbpH98UUCorLXNvEw+LUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669633509; x=
        1669640709; bh=9KW+v1Zm5o9jjtnNYe44GqrcuqH32RH+LlZRtrF9EjQ=; b=J
        MQCIX1rYkxoh7A7rTmuzz6YS3sJohkGT2B6vYJciK4iBwP20YhftyZckv/Xnpvfr
        P89sOYQgv+J2M7veayfvThJtl0jwJ8JteTNjHinpkc8Caf98ej+8G/0j6R2H+DCA
        6ijhf/1Jp6rI62orFswQf3V6hpR7frNK/7T+Pmri2y4L70PH83bVns6CwsJzrpzJ
        E3HinWqu0FccDhFdFA8zxHK9A/gQgpdmscD836x+iZ63/rimfonoMLfi9ojfmmKK
        8QCLi6OvHv7mhSy9Sl3b9iGUkHK9FQvYSBb5qcKx3EO3wXnL8C5snWguw91vGKWc
        q+ZW2caaC7Cx0RO7RuSsA==
X-ME-Sender: <xms:5JWEY6JToVv9hCJyDpW64NjhSEG5pxTegaf7kiQYmJvqCgSUEuwx3w>
    <xme:5JWEYyJEItKI6PIDhH30nj_aMFSrAReCE3lypORUdQeaC_uMTXFiTaye_fKH-vD89
    eqzgSRJjqmdDUO92Jw>
X-ME-Received: <xmr:5JWEY6vmhYSax2sMv3MexNTtp32j8M2crZcWmgU_qeVsb3NsL9repanFc0B4nyOGchdYdzG4hto_g7gp2_nRfRr6alxpBLkGF-g1NJp8xfZaOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:5JWEY_ZEyO5Kbizi7oZVgSg__5DEr0xlNzSyvfyKopgUUCjFrEQAfQ>
    <xmx:5JWEYxYlRrxYbQOMTl53zA-gIOHWhzHsEIkobPIUyQUyaPEH3k_Ldw>
    <xmx:5JWEY7AqXvSAgbOg8Ssd3ugceraRvIIt2eGCjzNimVccp-aagzHfGQ>
    <xmx:5ZWEY17NmQnxgziJTIvGBWLzeWnIvXv-AlA3dfr9zb0nNI8OpdmYZQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 06:05:08 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>, linux-media@vger.kernel.org,
        =?UTF-8?q?Ma=EF=BF=BD=EF=BF=BDra=20Canal?= <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: (subset) [PATCH 10/24] drm/vc4: kms: Sort the CRTCs by output before assigning them
Date:   Mon, 28 Nov 2022 12:04:54 +0100
Message-Id: <166963342297.56696.14963100604547824820.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123-rpi-kunit-tests-v1-10-051a0bb60a16@cerno.tech>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech> <20221123-rpi-kunit-tests-v1-10-051a0bb60a16@cerno.tech>
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

On Wed, 23 Nov 2022 16:25:52 +0100, Maxime Ripard wrote:
> On the vc4 devices (and later), the blending is done by a single device
> called the HVS. The HVS has three FIFO that can operate in parallel, and
> route their output to 6 CRTCs and 7 encoders on the BCM2711.
> 
> Each of these CRTCs and encoders have some contraints on which FIFO they
> can feed from, so we need some code to take all those constraints into
> account and assign FIFOs to CRTCs.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
