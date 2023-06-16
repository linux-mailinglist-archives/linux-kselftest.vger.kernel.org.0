Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9637339EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 21:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbjFPTdV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjFPTdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 15:33:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CADF12B
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 12:33:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec9bso9669095e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686943997; x=1689535997;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8YUPG0gHlr0qdifRw59HRCNCs5yl9INP4pgZg5LJP8=;
        b=0etDsxmS6bHu9cBwPDMoYF2tm6ShbJOgfI7lb/XbGQ1ociWiIHHXk7mSVT9uC0VM5s
         DOWlodVaMtZA6oH35v4+YCe0MxlVu94/Gi2AD8gl19AWTQM36i2gfjOvCZotAPfyLxp0
         GgfnAkD/ZYC8l8aJei6xzWZ2jxlHgNsnodv2zK4oGnCWNjx+v25gy8foRJImxMKFzESn
         l3KXN4AfqkhfUvmAMv+Jhgoi+eVl0f0kNqLmVttkWQJSL2Ucim8OICEZPiHKFrsgkVEH
         1eWbatsTymvmsmCk3SukkOJEDup1k6BG8Rhmz8AUZcU8YWv9r0pve3Iqnvi6n5hYEz3u
         qSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686943997; x=1689535997;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n8YUPG0gHlr0qdifRw59HRCNCs5yl9INP4pgZg5LJP8=;
        b=NsC6ygp2OvNFtM7c5P5iY8Vqky3I69UM90JuI1pxGGMXQQ/xLnoVdDjS8c0i11vnv8
         AugHsJ5KRO+ojMpE7nXd8UJQO/I2iy2EsXYNzIXzFOd+/BwD3YT4mK+yrDY3BiLO64GG
         srjXLCPe+YpcsCMtI5A4/Jq/eS/izQyRHl5iTWh0J8LpWF64/Ij/5oXy65UXvf6pLQIB
         RQW3FHFkcwBxrRi6CoLhGK6X6zF11MzyquzD+lK9B0t92mxY5iNkBzj+c2tbB2wqY8vN
         KeSWItFwVXL0g4UctEwZExFbPFSgl0hPDwLMV5/ZuHoT0C1pEr5WM1NjakBT3ukhYcsJ
         9YOA==
X-Gm-Message-State: AC+VfDxs8ZY6Uxdszkpr3KKJD96xJUos7KwbxVej/RIcfIdTxiVUJV7d
        dr44tznWeCOUWUKponhgs5GClw==
X-Google-Smtp-Source: ACHHUZ5dNi9Ewclb64p0a4euQCMEBcl5BtvyJedzVUA28VjsHXzoCpgV3GUuFNA+c1ojB2X3S8b1gA==
X-Received: by 2002:a05:600c:d8:b0:3f4:20ec:7601 with SMTP id u24-20020a05600c00d800b003f420ec7601mr2653977wmm.34.1686943996824;
        Fri, 16 Jun 2023 12:33:16 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a4fb:308c:d9af:9b31? ([2a02:578:8593:1200:a4fb:308c:d9af:9b31])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c024100b003f60e143d38sm3012126wmj.11.2023.06.16.12.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 12:33:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ZsTzgEaXjvQsTn7mKotqVps5"
Message-ID: <5007b52c-dd16-dbf6-8d64-b9701bfa498b@tessares.net>
Date:   Fri, 16 Jun 2023 21:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/4] selftests: net: fcnal-test: check if FIPS mode is
 enabled: manual merge
Content-Language: en-GB
To:     Magali Lemes <magali.lemes@canonical.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, dsahern@gmail.com,
        andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guillaume Nault <gnault@redhat.com>
References: <20230613123222.631897-1-magali.lemes@canonical.com>
 <20230613123222.631897-5-magali.lemes@canonical.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230613123222.631897-5-magali.lemes@canonical.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------ZsTzgEaXjvQsTn7mKotqVps5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Magali,

On 13/06/2023 14:32, Magali Lemes wrote:
> There are some MD5 tests which fail when the kernel is in FIPS mode,
> since MD5 is not FIPS compliant. Add a check and only run those tests
> if FIPS mode is not enabled.
> 
> Fixes: f0bee1ebb5594 ("fcnal-test: Add TCP MD5 tests")
> Fixes: 5cad8bce26e01 ("fcnal-test: Add TCP MD5 tests for VRF")
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Magali Lemes <magali.lemes@canonical.com>

Thank you for your patch!

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  d7a2fc1437f7 ("selftests: net: fcnal-test: check if FIPS mode is enabled")

and this one from 'net-next':

  dd017c72dde6 ("selftests: fcnal: Test SO_DONTROUTE on TCP sockets.")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side[1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, I simply took the modifications from both sides.

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/502f061b9a02
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------ZsTzgEaXjvQsTn7mKotqVps5
Content-Type: text/x-patch; charset=UTF-8;
 name="502f061b9a02bc02a62d4e136e65514211dc63c5.patch"
Content-Disposition: attachment;
 filename="502f061b9a02bc02a62d4e136e65514211dc63c5.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9mY25hbC10ZXN0LnNoCmlu
ZGV4IDA1YjVjNGFmN2EwOCxlZTY4ODBhYzNlNWUuLmQzMmExNGJhMDY5YQotLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvZmNuYWwtdGVzdC5zaAorKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9uZXQvZmNuYWwtdGVzdC5zaApAQEAgLTEyODMsMTAgLTEyMjMsNyAr
MTI5MCwxMCBAQEAgaXB2NF90Y3Bfbm92cmYoCiAgCXJ1bl9jbWQgbmV0dGVzdCAtZCAke05T
QV9ERVZ9IC1yICR7YX0KICAJbG9nX3Rlc3RfYWRkciAke2F9ICQ/IDEgIk5vIHNlcnZlciwg
ZGV2aWNlIGNsaWVudCwgbG9jYWwgY29ubiIKICAKLSAJaXB2NF90Y3BfbWQ1X25vdnJmCisg
CVsgIiRmaXBzX2VuYWJsZWQiID0gIjEiIF0gfHwgaXB2NF90Y3BfbWQ1X25vdnJmCiArCiAr
CWlwdjRfdGNwX2RvbnRyb3V0ZSAwCiArCWlwdjRfdGNwX2RvbnRyb3V0ZSAyCiAgfQogIAog
IGlwdjRfdGNwX3ZyZigpCg==

--------------ZsTzgEaXjvQsTn7mKotqVps5--
