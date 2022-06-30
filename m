Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010005618E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiF3LRt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jun 2022 07:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiF3LRt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jun 2022 07:17:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831D4D4C8
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jun 2022 04:17:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fw3so10690553ejc.10
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jun 2022 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xOuD0VayMLaVqMSm3qQEckL7M1TiFwHS72WWPKTLO58=;
        b=f2mg5NQcZInRzApmj3Hn1BwfNl1pudDvuPud+y6bW5QTphTs0bXap0Uu2pOmCLjt67
         13Xcr7cbtXO40QwP5BGR3/Lv14ByQi77QfcKQJTj7qwsgFHLYMfioS2b8xPcxClm0exN
         02p3T+AEeSkzysS7nxVSBskiMedr+oMz8YB+IB49n+wlv6Xw5o6bFyjETvnBcjFtmfNy
         WBv6ktj6+xlzz9y7+owgEUGG2ApUAOwv60wCPv8UVM8+o1cA2RPMvOR2txdT2PzZAaWo
         ijfpniC2e0HaioZ1VUHPbiJEFo37djO+X7EQpbklN41PWDjuWEwEMCoqLhxfyPvQhrkc
         8SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xOuD0VayMLaVqMSm3qQEckL7M1TiFwHS72WWPKTLO58=;
        b=a55u2dIRjvb/m7+soTYhV1b87v9sHziUixtwlAjoXmkB9FgQj5umR7+EjHxDkT4eGv
         4v7vYYp+M80WKRqbhkDKhTe/eC8XV+pPz/loXiCaTVLjbinjdd3uzVl7yXXz9kS1bI3x
         cicPEOnGWVfrlNC2o/WVLhdvzlmcGDqZmclT3NXH6yn6jSLZNeln7SQC8f4rtdJgfOIV
         UdmeK6+ZV076U8FvU/eoEzcejoZsuA95wIsWsvvFcjr66g5og6v3w6mqO0XcdHoJTvpY
         Cy+cb/tAsAbxMJMEgCWJQCiCUiQLhzp4/itXz4h2O/OdYp7E08Fh8Blxe9G70qxsvu6t
         T2rg==
X-Gm-Message-State: AJIora/UrAfps1OAOJilONYx7Vt43wWkWZz+RlGfbxVSngofKgEKvL9n
        qiZJT52uFxNrGcYW7C0QbtL3/w==
X-Google-Smtp-Source: AGRyM1sTwlP8l8cSXnZAeirtFdsJCaUPo0dMEU/k0FpVqeYgtZw9UTyY9WN6rJ5Nib2hOc5JVBVPWQ==
X-Received: by 2002:a17:906:149b:b0:726:2968:e32a with SMTP id x27-20020a170906149b00b007262968e32amr8420709ejc.71.1656587866001;
        Thu, 30 Jun 2022 04:17:46 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id pv1-20020a170907208100b00726abf9cd8esm4697467ejb.125.2022.06.30.04.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 04:17:45 -0700 (PDT)
Message-ID: <80d971ea-88b9-0d21-b6f4-93124ba6a678@blackwall.org>
Date:   Thu, 30 Jun 2022 14:17:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH net-next v1 1/1] net: bridge: ensure that link-local
 traffic cannot unlock a locked port
Content-Language: en-US
To:     Hans Schultz <hans@kapio-technology.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hans Schultz <schultz.hans+netdev@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org
References: <20220630111634.610320-1-hans@kapio-technology.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220630111634.610320-1-hans@kapio-technology.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30/06/2022 14:16, Hans Schultz wrote:
> This patch is related to the patch set
> "Add support for locked bridge ports (for 802.1X)"
> Link: https://lore.kernel.org/netdev/20220223101650.1212814-1-schultz.hans+netdev@gmail.com/
> 
> This patch makes the locked port feature work with learning turned on,
> which is enabled with the command:
> 
> bridge link set dev DEV learning on
> 
> Without this patch, link local traffic (01:80:c2) like EAPOL packets will
> create a fdb entry when ingressing on a locked port with learning turned
> on, thus unintentionally opening up the port for traffic for the said MAC.
> 
> Some switchcore features like Mac-Auth and refreshing of FDB entries,
> require learning enables on some switchcores, f.ex. the mv88e6xxx family.
> Other features may apply too.
> 
> Since many switchcores trap or mirror various multicast packets to the
> CPU, link local traffic will unintentionally unlock the port for the
> SA mac in question unless prevented by this patch.
> 
> Signed-off-by: Hans Schultz <hans@kapio-technology.com>
> ---
>  net/bridge/br_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 68b3e850bcb9..a3ce0a151817 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -215,6 +215,7 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>  	if ((p->flags & BR_LEARNING) &&
>  	    nbp_state_should_learn(p) &&
>  	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
> +	    !(p->flags & BR_PORT_LOCKED) &&
>  	    br_should_learn(p, skb, &vid))
>  		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
>  }

LGTM, thanks!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
