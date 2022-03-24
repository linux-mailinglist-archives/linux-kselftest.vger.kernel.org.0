Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47C4E63C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 14:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350370AbiCXNCD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Mar 2022 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350354AbiCXNCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Mar 2022 09:02:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB93F90CEA;
        Thu, 24 Mar 2022 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YG01IvqBzypFttWyr61/58YsVshIZUGldKDL1nfzsRk=;
        t=1648126828; x=1649336428; b=DuhBj2JSpSD9rd/13a4sA3PxCrlZTitxsNZPmMuyP8GHczM
        HbnJCN1qUqUa/FXw5hTf/MxZd61rL2ugJ2M6X0bAE/+6Hm0VAHZjkfU5Azw7cz17seJQpaVIADgJK
        Lj6tC5YMLATzMVB78XYdl8kELZMHpxcVP2ZuWEcKV+95raCTwe49e+LyNCfmEEkNVHUPVby8Cvd8q
        vb27xv6T4J/WgwpGCjJFdJAU4gvbHCfqjds+SfvP+QvkWLJngVELiktioaWiVTYuzpQDyRKtqa22q
        RXR8SN9AaqL1Z2wz69tTzFBD+0Y5Iv2HC8Q70YUgfLqBVU4HB9X/GiaOE4+2QPcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nXN4V-00HWDe-B6;
        Thu, 24 Mar 2022 14:00:11 +0100
Message-ID: <7f405d8d09a83954aa3411eff8b71ee687c7ec33.camel@sipsolutions.net>
Subject: Re: [RFC v1 01/10] roadtest: import libvhost-user from QEMU
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@axis.com, devicetree@vger.kernel.org,
        linux-um@lists.infradead.org, shuah@kernel.org,
        brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        jic23@kernel.org, linux-iio@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Date:   Thu, 24 Mar 2022 14:00:10 +0100
In-Reply-To: <20220311162445.346685-2-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
         <20220311162445.346685-2-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-03-11 at 17:24 +0100, Vincent Whitchurch wrote:
> Import the libvhost-user from QEMU for use in the implementation of the
> virtio devices in the roadtest backend.
> 

So hm, I wonder if this is the sensible thing to do?

Not that I mind importing qemu code, but:

 1) the implementation is rather complex in some places, and has support
    for a LOT of virtio/vhost-user features that are really not needed
    in these cases, for performance etc. It's also close to 4k LOC.

 2) the implementation doesn't support time-travel mode which might come
    in handy

We have another implementation that might be simpler:
https://github.com/linux-test-project/usfstl/blob/main/src/vhost.c

but it probably has dependencies on other things in this library, but
vhost.c itself is only ~1k LOC. (But I need to update it, I'm sure we
have some unpublished bugfixes etc. in this code)

johannes
