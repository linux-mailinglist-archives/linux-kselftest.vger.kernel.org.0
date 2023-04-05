Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F66D72B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 05:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjDEDPW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 23:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjDEDPV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 23:15:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FAE3C3F;
        Tue,  4 Apr 2023 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=J2oLC7V3hwrPHH7NbcvL0/7jOfylZw1zfDN3zohO/IM=; b=SpVWlTEO3jmNZ0HiKylaQjea5p
        Xlf7cUkQfEc+igIMI/Ni5zdLGgXKfwHmx3gyDktAs7i+7aEGc4dACkDYccDOPZnI9OgP21xrJYm6V
        uOOvjAJGuam9hJGhNsRNCnfj+sFbBQyjp1J698V3DoGmN70oOA3YI/Q68DwDt0ZUndAy4etlOy10a
        JAQWAyatL2Hn1rPXcY1/DvdPyzG30rPs0aUIrkcE5FxjEMnjEW034ncorTLg0VVtM8ejLSnvblgnu
        2znU/c8ocSJwu99oEbKAK1/6X+ia38VoAIqbsWMRcbzbOlRF4N45DJa0s0kmCRgPJ6TW6sKRNOel4
        cHtf4vmA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjtcA-003CPN-2w;
        Wed, 05 Apr 2023 03:15:15 +0000
Message-ID: <15521c65-1501-9394-8845-4d4ef983e6b6@infradead.org>
Date:   Tue, 4 Apr 2023 20:15:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Kernel panic, CONFIG_FIPS_SIGNATURE_SELFTEST, missing dependency
Content-Language: en-US
To:     "Kernel.org Bugbot" <bugbot@kernel.org>, bugs@lists.linux.dev,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        shuah@kernel.org
References: <20230403-b217293c0-1e5391e4b7f5@bugzilla.kernel.org>
 <20230404-b217293c6-010748a08594@bugzilla.kernel.org>
Cc:     linux-crypto@vger.kernel.org, David Howells <dhowells@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230404-b217293c6-010748a08594@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[adding linux-crypto and dhowells]


On 4/3/23 23:17, Kernel.org Bugbot wrote:
> o6irnndpcv7 writes via Kernel.org Bugzilla:
> 
> Hi Randy!
> 
> I submitted an example config. 
> That config works fine for me, until I set: 
> 
> CONFIG_FIPS_SIGNATURE_SELFTEST=y
> 
> And it starts working well again if I set:
> 
> CONFIG_FIPS_SIGNATURE_SELFTEST=y
> CONFIG_CRYPTO_SHA256=y
> 
> That's why I think it is related to FIPS_SIGNATURE_SELFTEST.
> 
> 
> Thanks,
>   sephora
> 
> View: https://bugzilla.kernel.org/show_bug.cgi?id=217293#c6
> You can reply to this message to join the discussion.

I'm not making any progress on this bug, so asking others for help.


Is there anything in the FIPS_SIGNATURE_SELFTEST code (selftest.c)
or code that it calls that requires CRYPTO_SHA256?

-- 
~Randy
