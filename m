Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6669F53E949
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jun 2022 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiFFKNh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jun 2022 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiFFKN1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jun 2022 06:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78A8DA26D3
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jun 2022 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654510150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTpeojEBTrseUaMSVnCmShJgLb05X1O3wixL+XWUD1U=;
        b=OMOaXy/VNFfHinihnlDEM8esewD6kzhZTY0BHPCg7b09F3wx+mHSSGYiupRzWjLsAqRoPC
        QuvpOkPa7bD2b+OJqSejBN/k/mR1EuAzO+YX+Br9x9XG2l6se9aNlpnvAeOyQLsoJPbjin
        AAJccHo/+so9blK5ZuZkHzaErtc0HrU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-uj1UrxEmOtukWSCoxzyo_A-1; Mon, 06 Jun 2022 06:09:09 -0400
X-MC-Unique: uj1UrxEmOtukWSCoxzyo_A-1
Received: by mail-wr1-f70.google.com with SMTP id v14-20020a5d610e000000b00213b51a0234so1971508wrt.11
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jun 2022 03:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WTpeojEBTrseUaMSVnCmShJgLb05X1O3wixL+XWUD1U=;
        b=Qu+KyvVoMblfVYMuvNrUPBjvmcHZDufpd4ehklg4fDyoopDsTSIOva5MwFb9Q4pOTY
         /B3z4si8Q4aoC0h4pJ+xphEbGSNKZ1uW92EVc+lSOaQ5dlNS5UtdENTjpa3/2yAj0470
         GaHjxEcbzuCjIoPg2DHZOrcpfz++W/3+1ZjbqM79e1QAJjeEIro3v8sOEOFSDBTkpsfL
         heL2Kc3B576jkwAmWIECgRx0hDM9tDmM5qAy0EcS6ngBl0m+DhHP8ZVD5mCk9WNCR6J0
         nSe4tzyz8Sv9WkcT4yACDoKL4sLRWmYY5buHGDXGdNEdqqwunM5cJQD0K3RsUpiiiDQs
         Qdjg==
X-Gm-Message-State: AOAM5336SOQQHsDu2Ph6BLrOvzsf9AUIzHwTQVC8Lm8kJPTMkZ3Fc1dC
        xyBUUdRniDgqgKK9S2FHrYWy08byhytFEqXDA+5Te/ts+e+wd256eXHfl7BzgnWjVJ78kVEiFcX
        tNKc7k27k2JGApxbsm9poR02iIxlV
X-Received: by 2002:a5d:6651:0:b0:210:3e1c:1343 with SMTP id f17-20020a5d6651000000b002103e1c1343mr20795216wrw.137.1654510148490;
        Mon, 06 Jun 2022 03:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfuD0eMUP2v47G3d9f7pYllLF29ZboA6bfNKjPqw3VCslRaoPuPFtSStztMn0yQpS9t0z6uQ==
X-Received: by 2002:a5d:6651:0:b0:210:3e1c:1343 with SMTP id f17-20020a5d6651000000b002103e1c1343mr20795194wrw.137.1654510148287;
        Mon, 06 Jun 2022 03:09:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b0039c4e2ff7cfsm3344360wms.43.2022.06.06.03.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:09:07 -0700 (PDT)
Message-ID: <c8031ab902a2636d4badfe3fdff65930a1f2ac56.camel@redhat.com>
Subject: Re: [PATCH v3] selftests net: fix bpf build error
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lina Wang <lina.wang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maciej enczykowski <maze@google.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Mon, 06 Jun 2022 12:09:06 +0200
In-Reply-To: <20220606064517.8175-1-lina.wang@mediatek.com>
References: <20220606064517.8175-1-lina.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2022-06-06 at 14:45 +0800, Lina Wang wrote:
> bpf_helpers.h has been moved to tools/lib/bpf since 5.10, so add more
> including path.
> 
> Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-tests")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Lina Wang <lina.wang@mediatek.com>
> Acked-by: Song Liu <songliubraving@fb.com>

LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>


