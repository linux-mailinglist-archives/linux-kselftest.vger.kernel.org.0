Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C20633CF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 13:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKVM4L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 07:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiKVMzs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 07:55:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1961525
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 04:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669121694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfHnKgkTBDMrBm8PUI8Fl6SbsIzlbvafvKcNrxienW8=;
        b=cBvj2UgwVhJnFL9lTHCldW0JJeOD0hpaEjJlb0NTfW0w61i8fSLB0aZ0vHmWR+1c3teihS
        1WriykjgMvZqWFt0cMlBeIOqmkVXmflRjKlIqMT10ICNhJ2UJOtT0MIACyIocS1qgWwiWN
        yWQoZiST/nuezUduRBqDLF+nmIS8r6k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-4MbiyuvsMVirzXNOmt29ZQ-1; Tue, 22 Nov 2022 07:54:53 -0500
X-MC-Unique: 4MbiyuvsMVirzXNOmt29ZQ-1
Received: by mail-qv1-f70.google.com with SMTP id og17-20020a056214429100b004c6ae186493so4701497qvb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 04:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PfHnKgkTBDMrBm8PUI8Fl6SbsIzlbvafvKcNrxienW8=;
        b=EO99alGt52aNix5budW/WNj6DyCt88lX8JstcKK12JSHfjDwea9mwV7LlZx6n6Cnvt
         fWySTvXbPe+SdoDt/U6jwO5NlAEek1MGcMgCoDNniqrRwlJ29qs+Ev/G/ACMFdlcgSVz
         pnMkPPVwDlCKEy/oKhT2RY4BGgiUH21hZruv0xnSrnMxXgMooLMsUJiG6b+2XoJ7q8+q
         UsV3lXEFMNiuzrQyvEAXAg2I8a0lmrO76nvFlflj4+OcZF45tHGhDM5eNgevBEOg4CbF
         684obRaLfHKq6ZXqUkoCGiHrtQJzA7t6MlUXR63B/Ih3Txg31qSvMb5O66u+IQuFWkVF
         WRxA==
X-Gm-Message-State: ANoB5pkmcDWYxo7hlC5Zak1YYXIb8ov+Rs4dLkrILkJDKixKSfqOS/mK
        Glb3/HM4iN4/mJVRZdY0qaQyIGPyTZaTSJEIrcB1nCJjBeeqzbTxdORCXvKq0ObzXPvlIDT8HdQ
        1cvklNHmOYu0QHk083kFlAxpAiWS2
X-Received: by 2002:ac8:5441:0:b0:3a5:7ba9:704f with SMTP id d1-20020ac85441000000b003a57ba9704fmr21993798qtq.331.1669121692384;
        Tue, 22 Nov 2022 04:54:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6sB1UeXO6TfXaiROwERQDrXihHhPOOYXKOffZOZkVabz1mI2VJFjAK1bEaGqc+z6CdzyzfSQ==
X-Received: by 2002:ac8:5441:0:b0:3a5:7ba9:704f with SMTP id d1-20020ac85441000000b003a57ba9704fmr21993788qtq.331.1669121692163;
        Tue, 22 Nov 2022 04:54:52 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id z63-20020a37b042000000b006fafaac72a6sm9896291qke.84.2022.11.22.04.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:54:51 -0800 (PST)
Message-ID: <ee1de4c0e20d4af6b65b6c209d1e8df6b13812ab.camel@redhat.com>
Subject: Re: [PATCH net-next] selftests: net: Add cross-compilation support
 for BPF programs
From:   Paolo Abeni <pabeni@redhat.com>
To:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Lina Wang <lina.wang@mediatek.com>,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 22 Nov 2022 13:54:48 +0100
In-Reply-To: <20221119171841.2014936-1-bjorn@kernel.org>
References: <20221119171841.2014936-1-bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 2022-11-19 at 18:18 +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The selftests/net does not have proper cross-compilation support, and
> does not properly state libbpf as a dependency. Mimic/copy the BPF
> build from selftests/bpf, which has the nice side-effect that libbpf
> is built as well.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
> Now that BPF builds are starting to show up in more places
> (selftests/net, and soon selftests/hid), maybe it would be cleaner to
> move parts of the BPF builds to lib.mk?

+1 on such follow-up ;)

Thanks!

Paolo

