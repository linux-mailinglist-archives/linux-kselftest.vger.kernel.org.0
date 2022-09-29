Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3B5EF95C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiI2PpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 11:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiI2PoZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 11:44:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3131BB20F
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 08:43:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g130so1207894pfb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=b7VI/lNtki3zEef+0LBeBHdkR7jGYNMrvxJja3PqG/c=;
        b=Vzksrx3sniIo56OPl72BWHlU0/Df8j/JQCbDZvy1EGrf7kGm7B2aiZfENf5gW44D/J
         gI9Z0IM1eNvyuoepwUgJtEreELCtd/Yi97PNwccOEhM6E0notm+GqKPkHLkR9oYsyKb8
         Yoq/pleXGN8k4RyGciZfN2tWjdiAPNPkdJ0GRF8seENVYF2FOicZ45TlpxCNGouCgsOp
         P0XmWHkJpwHysnW3nZxveeGX+rb2ESXrOcsYARReYp7X/HAFCqXhQu1KdtVjt8W5CRIo
         QDL3OSbkonYl6GqgtkUeoFLMwgh1qC0e+3cPxCbPucD2iWViRSqwTxmu6i6Uq7X8iEVv
         wfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b7VI/lNtki3zEef+0LBeBHdkR7jGYNMrvxJja3PqG/c=;
        b=3R+FfHpZmUXXrXFBzhYEqFnKVdqAoPl3oB/26ZnhIzR5lWg9bOyH3NE1V4HhKXryQQ
         YLs5WLdGSEwjA3Dy2PBI+Udq6QhsSa8AUGe/6Jo9J7kGmAWv1AFQUytlc1t1A+uXfgjR
         lZtL4Db+Aa7I+vobf0+QJ/jMG/z2yogKiKSkdiCTEcZtYJUXo5PuGOJ8JumVOVpJr3Wy
         adjVbocSZuKkjmfCXAZJo2RKhYm2DQvBIx41TQb2HiZCudgMEOGV9XIVEeRK/M5c2Eo3
         sisXSefDC4S7WVyn1dEmlkHUBF4BWz2mxBKIIyEfIVHjnptmWlhE559T+BcmdKKCShJr
         o4TA==
X-Gm-Message-State: ACrzQf1h6g/OeIfrcPwZaSpN7Ep+qDhdv6C5AKRm1F9CRB44HUdRCs3+
        CiJ5fxzpwkUM4pu67cKMn5l+oA==
X-Google-Smtp-Source: AMsMyM5rOGzlC007WW3U9p2PPqvx0IpfKhVuFQ42vcDUakNLelXGGyhbF2WyHTattavi5pSMM7s+ng==
X-Received: by 2002:a05:6a00:1412:b0:557:d887:2025 with SMTP id l18-20020a056a00141200b00557d8872025mr4076191pfu.39.1664466194646;
        Thu, 29 Sep 2022 08:43:14 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001768452d4d7sm56745plg.14.2022.09.29.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 08:43:14 -0700 (PDT)
Date:   Thu, 29 Sep 2022 08:43:12 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Hans Schultz <netdev@kapio-technology.com>
Cc:     davem@davemloft.net, kuba@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org,
        Joachim Wiberg <troglobit@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Ivan Vecera <ivecera@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ido Schimmel <idosch@nvidia.com>,
        bridge@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Roopa Prabhu <roopa@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Hans Schultz <schultz.hans@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yuwei Wang <wangyuweihx@gmail.com>,
        Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Vladimir Oltean <olteanv@gmail.com>,
        Florent Fourcot <florent.fourcot@wifirst.fr>
Subject: Re: [Bridge] [PATCH iproute2-next 2/2] bridge: fdb: enable FDB
 blackhole feature
Message-ID: <20220929084312.2a216698@hermes.local>
In-Reply-To: <20220929152137.167626-2-netdev@kapio-technology.com>
References: <20220929152137.167626-1-netdev@kapio-technology.com>
        <20220929152137.167626-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 29 Sep 2022 17:21:37 +0200
Hans Schultz <netdev@kapio-technology.com> wrote:

>  
> @@ -493,6 +496,8 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
>  			req.ndm.ndm_flags |= NTF_EXT_LEARNED;
>  		} else if (matches(*argv, "sticky") == 0) {
>  			req.ndm.ndm_flags |= NTF_STICKY;
> +		} else if (matches(*argv, "blackhole") == 0) {
> +			ext_flags |= NTF_EXT_BLACKHOLE;
>  		} else {
>  			if (strcmp(*argv, "to") == 0)
>  				NEXT_ARG();

The parsing of flags is weird here, most of the flags are compared with strcmp()
but some use matches()..  I should have used strcmp() all the time; but at the
time did not realize what kind of confusion matches() can cause.
