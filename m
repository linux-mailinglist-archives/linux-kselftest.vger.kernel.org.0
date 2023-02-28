Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF646A584A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 12:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjB1LeU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 06:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjB1LeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 06:34:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04DE6198
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Feb 2023 03:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677584003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Td4oddmmM1+vJS0lWsyO8iL6ac/jcvqUOESFVNQcxyQ=;
        b=I+Ah4p2bZfyQjJDkOpkxzhfZXkO3z3FJz/Pqje8kLnMXFXhOdgS1anAVhRZSZ6zUq11uVO
        r/McgOJkE5ckuF1L3lR5vnIybO3k2f5yvxBIE2u9B7k4cZn++E6bIrNSUiRjSsmOCuSr/8
        TRcMIFdlR/9jW7CPeg2cV1GT9eERkKY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-348-lv-JaByqM3OfdOUju-euWg-1; Tue, 28 Feb 2023 06:33:22 -0500
X-MC-Unique: lv-JaByqM3OfdOUju-euWg-1
Received: by mail-wm1-f71.google.com with SMTP id x18-20020a1c7c12000000b003e1e7d3cf9fso6778567wmc.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Feb 2023 03:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Td4oddmmM1+vJS0lWsyO8iL6ac/jcvqUOESFVNQcxyQ=;
        b=mU0yRzddmSZpI1Gfb6HJ0AXPev5g01fRrATf8G3jbz3VNtEqlv9T0mPg/UtWn40Zcx
         IRNMnQoB9rH+pPHGoVj0bTWo0bLl2R/bA1xMg3iGy+EP412hdMcn6Kt6Wn8SV8GbnbAt
         BNPgZ30qp+qqqIhrwsre+7MY+WP9nCWrixBgecTtVo0Ciu4Ed2gsK1DQmpFDHISQ02QJ
         6+f842TwLzfZcREw5W+5Cv3SAoboFd6HCvXniG333Otr47QyGC3KyhcPwMsWg+0+NA2s
         mA9RBErn7FDsondpL8bllplXQkaSNc6e4qg2Mb8tu+MmwyZTmC+kFmEIV5fBN5vi4kMg
         to/A==
X-Gm-Message-State: AO0yUKWVD5WBhqKUb+knQ6qwgUfAUW6muNmX9O3jeA9Xl4CZQQ8Pdkr0
        sbfCzoKf2BuMI1cCB7ncRiChaGAAsagoXAGkcMPGmee6MUfhw2Rppb6Y0xUA+7TQDw6xlhBQ6H+
        bUcsoQsDLB4bDU+rOrT7PhCu5HBIs
X-Received: by 2002:a5d:5962:0:b0:2c9:8b81:bd04 with SMTP id e34-20020a5d5962000000b002c98b81bd04mr1569323wri.0.1677584000918;
        Tue, 28 Feb 2023 03:33:20 -0800 (PST)
X-Google-Smtp-Source: AK7set9Q9kIQxqyRlatsve8g0wcgxyegweDnlQJHTOCP2QArZXsRYiS2XU5fqY0HFcUTe47lj7xTDw==
X-Received: by 2002:a5d:5962:0:b0:2c9:8b81:bd04 with SMTP id e34-20020a5d5962000000b002c98b81bd04mr1569305wri.0.1677584000626;
        Tue, 28 Feb 2023 03:33:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b002c54c9bd71fsm9793687wro.93.2023.02.28.03.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:33:19 -0800 (PST)
Message-ID: <4a10c2acacf8ca3e34c5452c44fe21bbcc26e271.camel@redhat.com>
Subject: Re: [PATCH net 0/7] mptcp: fixes for 6.3
From:   Paolo Abeni <pabeni@redhat.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Mengen Sun <mengensun@tencent.com>,
        Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>,
        Jiang Biao <benbjiang@tencent.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Christoph Paasch <cpaasch@apple.com>,
        Geliang Tang <geliang.tang@suse.com>
Date:   Tue, 28 Feb 2023 12:33:17 +0100
In-Reply-To: <a0a76c20-4fd9-476b-3e32-06f7cc2bbf1b@tessares.net>
References: <20230227-upstream-net-20230227-mptcp-fixes-v1-0-070e30ae4a8e@tessares.net>
         <a0a76c20-4fd9-476b-3e32-06f7cc2bbf1b@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2023-02-28 at 12:28 +0100, Matthieu Baerts wrote:
> Hello,
>=20
> On 27/02/2023 18:29, Matthieu Baerts wrote:
> > Patch 1 fixes a possible deadlock in subflow_error_report() reported by
> > lockdep. The report was in fact a false positive but the modification
> > makes sense and silences lockdep to allow syzkaller to find real issues=
.
> > The regression has been introduced in v5.12.
> >=20
> > Patch 2 is a refactoring needed to be able to fix the two next issues.
> > It improves the situation and can be backported up to v6.0.
> >=20
> > Patches 3 and 4 fix UaF reported by KASAN. It fixes issues potentially
> > visible since v5.7 and v5.19 but only reproducible until recently
> > (v6.0). These two patches depend on patch 2/7.
> >=20
> > Patch 5 fixes the order of the printed values: expected vs seen values.
> > The regression has been introduced recently: present in Linus' tree but
> > not in a tagged version yet.
> >=20
> > Patch 6 adds missing ro_after_init flags. A previous patch added them
> > for other functions but these two have been missed. This previous patch
> > has been backported to stable versions (up to v5.12) so probably better
> > to do the same here.
> >=20
> > Patch 7 fixes tcp_set_state() being called twice in a row since v5.10.
>=20
> I'm sorry to ask for that but is it possible not to apply these patches?

Done, thanks!

Paolo

