Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961386D38A5
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 17:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjDBPHX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjDBPHW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 11:07:22 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C818A73;
        Sun,  2 Apr 2023 08:07:21 -0700 (PDT)
Date:   Sun, 2 Apr 2023 15:07:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680448040;
        bh=4hoeS1AG5TT22GF/AX/PrvaGgitME1JepnPdgtVCQ5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gw+WlslVpht56HiY4GYcGPzF9fiXbrlmFrE1JTfIXqhvLVXmGrttZf4RXUMeNFT1M
         c1A+znX5te+VVl8T96Esb6dMrV8lZx6JJ/EHY2YKC6XBk9taAC+YNZc/c31JZklsR0
         +e5tzQPPSZfYplPZvucidD/ELi81Ra7ia7I44Y1I=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tools/nolibc: implement fd-based FILE streams
Message-ID: <d017ce53-b4e2-4068-8971-60cb02c90739@t-8ch.de>
References: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
 <20230328-nolibc-printf-test-v2-2-f72bdf210190@weissschuh.net>
 <ZCmLOruMPQDbfTyH@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCmLOruMPQDbfTyH@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-04-02 16:03:38+0200, Willy Tarreau wrote:
> On Sun, Apr 02, 2023 at 01:02:46PM +0000, Thomas Weißschuh wrote:
> > Willy:
> > 
> > This uses intptr_t instead of uintptr_t as proposed because uintptr_t
> > can not be negative.
> 
> Ah yes good point.
> 
> > +/* provides the fd from of stream. */
> > +static __attribute__((unused))
> > +int fileno(FILE *stream)
> > +{
> > +	intptr_t i = (intptr_t)stream;
> > +
> > +	if (i > 0) {
> 
> If you don't mind I'll change this to "if (i >= 0)" since we also want
> to set errno on NULL.

Sounds good.

> > +		SET_ERRNO(EBADF);
> > +		return -1;
> > +	}
> > +	return ~i;
> > +}
> 
> OK for the rest of the series.

Thanks,
Thomas
