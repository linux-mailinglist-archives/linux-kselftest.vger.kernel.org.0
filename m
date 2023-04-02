Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD9B6D37CE
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjDBMSy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjDBMSx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 08:18:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EABF25552;
        Sun,  2 Apr 2023 05:18:48 -0700 (PDT)
Date:   Sun, 2 Apr 2023 12:18:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680437927;
        bh=HgnUzY5jdht+A1fhfOMu126ZJ0nVRu6zSD1G0+lJ3WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4xMX0zBfj8xx7wVWCesb/43rn3h+Kz6EqrXHSSImaB8+vvkKHwVIQvFcoUTx0na+
         YvQ1lLRX42nSpaTVZglqlwmQno4///9na+Bqj/qdcQJY4ALjMAjVA/QD8iLwJi6Uex
         9/BFzssNdwEc8dR2ki9KiE+fGN5wisM1rx786SNE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: add testcases for vfprintf
Message-ID: <15dc87d0-99eb-451b-a0ad-ccf7d268b488@t-8ch.de>
References: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
 <20230328-nolibc-printf-test-v1-3-d7290ec893dd@weissschuh.net>
 <ZCk2BSCDE8ssl8fz@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCk2BSCDE8ssl8fz@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-04-02 10:00:05+0200, Willy Tarreau wrote:
> On Tue, Mar 28, 2023 at 09:01:31PM +0000, Thomas Weißschuh wrote:
> > +	fd = memfd_create("vfprintf", 0);
> > +	if (fd == -1) {
> > +		pad_spc(llen, 64, "[FAIL]\n");
> > +		return 1;
> > +	}
> 
> Also for this you'll need to include <sys/mman.h> in the part where nolibc
> is not detected so that it continues to work with regular libcs (at least
> glibc so that we have one reference to compare against).

Ack.
