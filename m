Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A864059B3E7
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiHUN0F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiHUNZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 09:25:58 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F61EC63
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 06:25:57 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0E8B830F324;
        Sun, 21 Aug 2022 15:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661088356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaUM92FmfgSVbdgrkEKDESj+y9oC2KFTF3Y2Ta4pFo0=;
        b=bTTHfrz9EFfRj/zShsDRnRCKVK2QXZpQYFGY8fm9Y51qFCGTcZttaoRCyttF8iML6X8AOl
        /xyBpzLv5ezCPA4SmHGgagoutJufgKzCfzzl9LK8HGRJg+g1Wa9riFSqE9buzV/TnZwcQL
        LClAYeqtvZHfaupulRoQLCUxICVi/lv3JqjU12v2FhDfow+ZD80xBN4v4nO3nR7Nno+Blt
        K4vXLXsxWGJWAZOCZh6kaZMi0uff2eB+g3ETHM5qX3XA86PC+cOlIQhgm0Re+V8iuewNOq
        qa+fvYErKF24Rn8NVAW+TYRuGpoYNsGFB181qTDnciivcQHTswpCIHx2VmkNPg==
Message-ID: <38507e4b4ab6972fa76d32d74da1911d6c4224d3.camel@svanheule.net>
Subject: Re: [PATCH v2 0/5] cpumask: KUnit test suite fixes and improvements
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Aug 2022 15:25:54 +0200
In-Reply-To: <YwFa0xiM/b0N5X0w@yury-laptop>
References: <cover.1661007338.git.sander@svanheule.net>
         <YwFa0xiM/b0N5X0w@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yury,

On Sat, 2022-08-20 at 15:06 -0700, Yury Norov wrote:
> On Sat, Aug 20, 2022 at 05:03:08PM +0200, Sander Vanheule wrote:
> > This series fixes the reported issues, and implements the suggested
> > improvements, for the version of the cpumask tests [1] that was merged
> > with commit c41e8866c28c ("lib/test: introduce cpumask KUnit test
> > suite").
> >=20
> > These changes include fixes for the tests, and better alignment with th=
e
> > KUnit style guidelines.
>=20
> I wrote a couple comments, but the series looks OK to me in general.
> So for 2, 3 and 5:
> Acked-by: Yury Norov <yury.norov@gmail.com>
>=20
> It's named as 'fix', but it fixes a test, and the kernel code itself
> looks correct. So, do you want to take it into 6.0-rc, or in 6.1?
>=20
> I'm OK to do it this way or another, but for later -rc's it may look
> too noisy. And I'm not sure where to put a threshold.

Broken tests are worse than no tests IMHO, so I would at least like patches=
 1
and 2 to be merged for 6.0-rc. I don't want people to end up with false
positives, like Ma=C3=ADra did, for an entire release cycle.

Preferably I would also like to see 3 in 6.0-rc, so no renames will be need=
ed in
6.1 anymore. Not that I expect anything to depend on this symbol (or filena=
me)
by then, but I feel it's better not to risk that by waiting for 6.1.

Patches 4 and 5 can go with 6.1, as far as I'm concerned. Especially as the=
 mask
logging patch (4) may need some work still.

Best,
Sander

