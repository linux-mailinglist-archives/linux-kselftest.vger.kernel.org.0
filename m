Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472726CEFE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjC2QxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjC2QxQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 12:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF76A4D
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680108746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=muo9JB5IQhuOp3WxvPbO5lqz9UUu3QBSHBndFfIKJqM=;
        b=N8jxHOoaSgo/KYQyd1Sdkp/jeSmdRup4wZRuRYnW8/DjLFmgnpGF06bE7L1ObM9z4Zr2YI
        HERzPK65kF9RLsBEVINQAT2snAeZfyGFG+wWKSFCd1PcWzNhNSii4Qru2egpCToqFtoOtd
        vYX5mardwmYuClGnYnH6ryYQgCYKs6E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Glo3xFLTOUaARzckGRDf0A-1; Wed, 29 Mar 2023 12:52:25 -0400
X-MC-Unique: Glo3xFLTOUaARzckGRDf0A-1
Received: by mail-qt1-f200.google.com with SMTP id l13-20020a05622a174d00b003e4df699997so8465868qtk.20
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 09:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680108745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muo9JB5IQhuOp3WxvPbO5lqz9UUu3QBSHBndFfIKJqM=;
        b=HP+1qwMmaNExohCodXI94G/D1S1911NbUEw59+9qNV1mSSd9s2DHBvJernveKJNMOP
         c93RvvD4ZuuTACeXihQ7yU1L2D6WhOyld9zrxyiF2qtJmfkugFpVFD2b06y5vILSTgsT
         gL8UppwyySbr7FWY2fMW8PvhG+dIs2fJ1YLNauEmCtxw7qqwoxkOFoxBAogO2gsUWx8n
         0R0JXeATQEJre/NcyxSOtxmDOuMifUss9GTAcEln+iBGZVLXDN1d0rnRKv5nv5YnYJjC
         1opvL6MAiBNFbahwnVKGInAHo4lO7uc48yoAC0fsNaU+KJleyzYRNLXJ3Sn6pjSSiWfI
         YS3w==
X-Gm-Message-State: AAQBX9cpJ8TBYcqzrk6okWFg3V4iR2S5LJ8F/iYxDkMydIXEJ/HMvPbG
        r21V7uvDTTvpW4Gz86HRoNLJV34Rxk2lQbWZOPDaVT33qD3N0Kkui0Z7afal/6M3/uW5QjZz4CS
        cLtWK8TxECIyZNlFfaRbFcX3kQXTH
X-Received: by 2002:a05:6214:e66:b0:583:8e58:6c0f with SMTP id jz6-20020a0562140e6600b005838e586c0fmr29147470qvb.40.1680108744895;
        Wed, 29 Mar 2023 09:52:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bun4cXrzEpCnPiNSCluwNvGX9z2Oj2GOli6rL0A1O/OgPE5/Cg6d1gD+r1Sj89T4hWGd39nQ==
X-Received: by 2002:a05:6214:e66:b0:583:8e58:6c0f with SMTP id jz6-20020a0562140e6600b005838e586c0fmr29147450qvb.40.1680108744648;
        Wed, 29 Mar 2023 09:52:24 -0700 (PDT)
Received: from debian (2a01cb058918ce00e2c03839ebb8a46a.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:e2c0:3839:ebb8:a46a])
        by smtp.gmail.com with ESMTPSA id r199-20020a37a8d0000000b007467b55e6e3sm14799362qke.89.2023.03.29.09.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:52:24 -0700 (PDT)
Date:   Wed, 29 Mar 2023 18:52:20 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: selftests: net: l2tp.sh regression starting with 6.1-rc1
Message-ID: <ZCRsxERSZiGf5H5e@debian>
References: <ZCQt7hmodtUaBlCP@righiandr-XPS-13-7390>
 <MW4PR11MB57763144FE1BE9756FD3176BFD899@MW4PR11MB5776.namprd11.prod.outlook.com>
 <ZCRYpDehyDxsrnfi@debian>
 <MW4PR11MB5776F1B04976CB59D9FE41BFFD899@MW4PR11MB5776.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB5776F1B04976CB59D9FE41BFFD899@MW4PR11MB5776.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 29, 2023 at 03:39:13PM +0000, Drewek, Wojciech wrote:
> 
> 
> > -----Original Message-----
> > -MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 2, IPPROTO_L2TP);
> > -MODULE_ALIAS_NET_PF_PROTO(PF_INET6, IPPROTO_L2TP);
> > +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 2, 115 /* IPPROTO_L2TP */);
> > +MODULE_ALIAS_NET_PF_PROTO(PF_INET6, 115 /* IPPROTO_L2TP */);
> 
> Btw, am I blind or the alias with type was wrong the whole time?
> pf goes first, then proto and type at the end according to the definition of MODULE_ALIAS_NET_PF_PROTO_TYPE
> and here type (2) is 2nd and proto (115) is 3rd

You're not blind :). The MODULE_ALIAS_NET_PF_PROTO_TYPE(...) is indeed
wrong. Auto-loading the l2tp_ip and l2tp_ip6 modules only worked
because of the extra MODULE_ALIAS_NET_PF_PROTO() declaration (as
inet_create() and inet6_create() fallback to "net-pf-%d-proto-%d" if
"net-pf-%d-proto-%d-type-%d" fails).

