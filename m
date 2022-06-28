Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58F455E955
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiF1OUd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiF1OUc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 10:20:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7220BD6;
        Tue, 28 Jun 2022 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=bGZWR4+xFQDcZf+1dFjdwobB0qRnC6+pf315BRLfGmw=; b=P+YP6JXp82I3hU0HChO35R7Xd5
        SlXmDXZWicbX2zdNga0elkAGrONI5wXy5yU2x7sSjY8AljxvBkYBG+rRDz5Ey1jajKiWEO2cgYk2j
        bZfnvlDg2OduF4iL3Y3QWbWw62OgHA2cVz5HlevQ37by6ZqZfT2mjXb1hwi9C0YYtWjBBwqpbvlOe
        rn4Zyrxvf3BJC+0dQP3ONHPMssC1Xpak1p4zjB154q37hYif/uf+hydGitiKez0WNoNyTM821wI1/
        TyHjtdSCs+jfuSKE+Xj95liXXik6VX8wC1AGILmORkZSYkhl0leBu8bx/A2CqtwJ+4yYA3I3mfrKa
        tAaOvBHw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6C4p-006gmR-KJ; Tue, 28 Jun 2022 14:20:27 +0000
Message-ID: <62cdc6ce-1940-8b94-6c96-0f48f62c03d3@infradead.org>
Date:   Tue, 28 Jun 2022 07:20:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Documentation: kunit: eliminate code-block warnings
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Harinder Singh <sharinder@google.com>,
        Tim Bird <tim.bird@sony.com>
References: <20220401024707.10550-1-rdunlap@infradead.org>
 <87fsjt50c8.fsf@meer.lwn.net>
 <4c403239-3c71-4ab9-2168-f7e9d77008b2@infradead.org>
 <20220628081744.7e6955e6@sal.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220628081744.7e6955e6@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mauro,

On 6/28/22 00:17, Mauro Carvalho Chehab wrote:
> Em Sat, 25 Jun 2022 08:12:00 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>>> So which version of Sphinx are you using?  The language argument became
>>> optional in 2.0, so you'd need to be running something pretty ancient to
>>> see this.
>>>
>>> Ah, I see 1.8.5 in your later message...how wedded are you to that
>>> version?  
>>
>> It's what ships with OpenSuse Leap 15.3, which I have been using for quite
>> a long time.
>>
>> I see that there is now OpenSuse Leap 15.4, so I could upgrade to that,
>> but I don't know what version on Sphinx it uses.
> 
> It seems that there are two versions on it, packaged with different
> names:
> 
> 2.3.1:
> 	https://download.opensuse.org/distribution/leap/15.4/repo/oss/noarch/python3-Sphinx-2.3.1-150400.1.7.noarch.rpm
> 4.2.0:
> 	https://download.opensuse.org/distribution/leap/15.4/repo/oss/noarch/python3-Sphinx_4_2_0-4.2.0-150400.11.6.noarch.rpm
> 
> It should be noticed that, while we don't decide to remove support for
> Sphinx < 3, kernel-doc has two different outputs, depending on Sphinx C
> domain support. The legacy support is enabled with version < 3 [1].
> 
> As we're currently discussing dropping support for Sphinx version < 3,
> I would recommend you to use the 4.2 package.
> 
> Regards,
> Mauro
> 
> [1] Version 3.0 is a bad choice, as the C domain is partially broken.

Thanks for the info. I'll take care of it.

-- 
~Randy
