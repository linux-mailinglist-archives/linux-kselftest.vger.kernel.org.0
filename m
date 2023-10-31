Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC27DCDD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 14:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjJaN1e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 09:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbjJaN1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 09:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DADDF
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698758808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eI/NB+UK7wm+ikX7wMjjd1LtGrSm/qZ7Qv6AHobbkPs=;
        b=hpUfFZKARRkCLpjWMlxRttLcYrMRYNxZsMflA2YWlO//3xRtLIb2TsSykVZRLIX3YMSSdp
        Kf7wwNAFgoWWOJma991VFYi+UFhfqmnv5lH0p9+1NnbMDEqSeLJeFBVuc6VIEQkdpatokZ
        jafEQJ08HMS/wKbDcvwj3CkQ/GpTfjc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-lRMEDDssPbeKBU8iL-Oxsg-1; Tue, 31 Oct 2023 09:26:47 -0400
X-MC-Unique: lRMEDDssPbeKBU8iL-Oxsg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41cc25beccaso69959391cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 06:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698758806; x=1699363606;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI/NB+UK7wm+ikX7wMjjd1LtGrSm/qZ7Qv6AHobbkPs=;
        b=JKaigsPyMVcTSdStt7ZKZUvyJap28sV3OQi1E7TZGipfNmNo7iOpbL/GhDEi/q94ts
         qPNKnJIdfXBQX2aZACRrwPq3tBkLTiwSKvo+rDMRjUtQHOCThwhJ/5uzfRisI1AJ76vK
         9yjh1JrFLRkymEYhRmietow4DMUglDmJw/1P9LI81pENa9ME+6pNj8EWOICltpybn78e
         xBu934fjjuHg05cVKGazBXvXBUB5jxqoc5jaB8L0AY6JhcUZ9f8yIfQeE4o8b4/BL+Js
         c+bcDvsZymeHOV1+7GoGKYCWaSZS/qsemtk26yDMvVdZjrvZdUO2WkaFcK8QhVub81uy
         3YSw==
X-Gm-Message-State: AOJu0YwoWZ8ogSo22B4B4UsWVMu2i2JmbxQ36yWUrdCmbhqb01vgGEhI
        lz0IRSKoa072IvCiKxDc6TGVb4jZWpkg5DR2ta97/mkR6BS4iTuSXR3PFu2len9mYZhVJNhcry6
        epUTq1F3Tv4CRN6H5DcRXvkqwZ4a+
X-Received: by 2002:ac8:5c07:0:b0:412:395c:e794 with SMTP id i7-20020ac85c07000000b00412395ce794mr16506851qti.50.1698758806644;
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJ+JdW34kAi/vPRSUYYZ/SunG5KPuPwv6RMEn5yGHPjewye+0V9zLeMALeZ3Oa1GIJGE7BQ==
X-Received: by 2002:ac8:5c07:0:b0:412:395c:e794 with SMTP id i7-20020ac85c07000000b00412395ce794mr16506834qti.50.1698758806379;
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id w26-20020ac84d1a000000b00405502aaf76sm492115qtv.57.2023.10.31.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
Date:   Tue, 31 Oct 2023 09:26:44 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
Message-ID: <vzz3qfbfq52qja24y25lopif27sdwyvz3jmmcbx5wm6jc5l53b@fy7ym6xk4zsb>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
 <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Since you wrote the same function verbatim in 3 different files, I
> think it would be better place it in separate, new, net_helper.sh file
> and include such file from the various callers. Possibly additionally
> rename the function as wait_local_udp_port_listen.
>
Thanks, I'll move it over. I think it would be best though to leave udp
out of the name and to just pass the protocol as an argument. That way
any future tcp tests can also take advantage of it.

Lucas

