Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61FB6E4B95
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDQOgH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 10:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDQOgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 10:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE9AD06
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681742107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKC9O5ntfTB8FFBQ3U6lqT7ATFuyfdua81IpKIWSC2c=;
        b=LB/hkokfWyl6DEJrB/UjeJV3Dy+Is+aRp1itFbJ3EDaSXTSILqpGcncgiJJaNDFMlxeopq
        91SvSy+qSGvGRmMapDRFRMznUpCMvjB5skIuz7htkliwlQhuFe6TGkBpxHE1wrJDjdHo4W
        dfNaCzhtrkl4i71iUZ8c5yrUYQ0xQHo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-0fC-hsP4OCaB0Kr8KlxrCA-1; Mon, 17 Apr 2023 10:35:06 -0400
X-MC-Unique: 0fC-hsP4OCaB0Kr8KlxrCA-1
Received: by mail-wm1-f70.google.com with SMTP id az39-20020a05600c602700b003f172e1d5bbso1797807wmb.9
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 07:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681742105; x=1684334105;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKC9O5ntfTB8FFBQ3U6lqT7ATFuyfdua81IpKIWSC2c=;
        b=DGl+H4tNhPlQ+AC10QVYptwAoSK/iXyxiPR4bTymJx7kqCsgB3ANyTU28LdbUpIKSO
         nEWAcBheU92TIJMO6YLHuIdsYVEhgQpo/dXMxfdeCwG1K4M33eIi6T6RQpH1t4slioVc
         kqzjfoSSZzlGQ8l0LJ9qhBTfWSsPc11HnpY47IbvM9OIJn9gUXFMGZzDtOp7NEfustTX
         +Laf++Hree54LsCfO32aKz1dU2SZbQFaYZRYhSPNPKoVWvf1zTjv7i6M6MTjuXJhANtq
         njmRi4f6Y96oHBsoQdFCqPVbynTiSfdPqzPgOqtLpPfYlvkNHufajMNdNfs10//Z8Bjs
         YZUg==
X-Gm-Message-State: AAQBX9e8cvTvzUEbwux6kW9Dm/DYPxhekGorPp+ZboTWXvuO/yhfzIME
        /+Qzpryzvn5JhCo31UphA1thBejUNVIOEUtGLVzIEtpJ+UtrqyUbVD4oVA5fAdlURDqT3S4GWKy
        muKoX0KnpwK37CdVGhP1oTnHxFwzM
X-Received: by 2002:a05:600c:2195:b0:3f1:7277:eaa with SMTP id e21-20020a05600c219500b003f172770eaamr3122993wme.31.1681742105525;
        Mon, 17 Apr 2023 07:35:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350aOrJE/aPCFeEwGeJSkkFbLEOP6OoqvoOsP3dJ51tp858c+XL14GvgOi/VSa7eA1BIISoC4kw==
X-Received: by 2002:a05:600c:2195:b0:3f1:7277:eaa with SMTP id e21-20020a05600c219500b003f172770eaamr3122981wme.31.1681742105222;
        Mon, 17 Apr 2023 07:35:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id s6-20020a7bc386000000b003f172ec4022sm4134398wmj.18.2023.04.17.07.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:35:04 -0700 (PDT)
Message-ID: <355f42d1-4354-376d-ab27-7e55d06e64a6@redhat.com>
Date:   Mon, 17 Apr 2023 16:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 3/3] selftests/mm: add new selftests for KSM
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230415225913.3206647-1-shr@devkernel.io>
 <20230415225913.3206647-4-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230415225913.3206647-4-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> +/* Verify that KSM can be enabled / queried with prctl. */
> +static void test_prctl(void)
> +{
> +	int ret;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
> +	if (ret < 0 && errno == EINVAL) {
> +		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
> +		return;
> +	} else if (ret) {
> +		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
> +	}

Just realized we're missing a "return;" in case of the failure here.

-- 
Thanks,

David / dhildenb

