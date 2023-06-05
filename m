Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86A722BFF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjFEPzs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 11:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFEPzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 11:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F6B7
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685980506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wwLGVmDqbkcCaY5EC3JMFUCO4whX8e6TfDsiOjgxq/Q=;
        b=XmAiOZQn2+0SLNUzuaVvNs9DYYya6yE9DresaIZ9JBoog7i2S1COnpd4Y98p8YccSs4OHJ
        RDQOIWS1ROU/H/SW269PP4njTPEZKLYedUl/L1RjOL4uwvmxRzl20tTgGzyRL6r8OcJdH4
        gHpzR35NrQ4fHPnh/syqQwsBAUpuNnc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-_4H136doO8GfrgusEegy2g-1; Mon, 05 Jun 2023 11:55:05 -0400
X-MC-Unique: _4H136doO8GfrgusEegy2g-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f9aa9aee8cso1399251cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 08:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685980504; x=1688572504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwLGVmDqbkcCaY5EC3JMFUCO4whX8e6TfDsiOjgxq/Q=;
        b=SQsvP5ctr4h3xhZUlXXSrDCfINz/BYMMOc9tTp8DGAXWYFXbEPY2z+Eb6nOTqIby2a
         G/deXndXsJMW5IAiesrJtxlD3fmTYRwrN9WAk+IlBPhKBS892+8f9+14sfdL9YjDhMJy
         hhqZspiKLTSaV/RFS2Wr3RTDDQO65WXSsJJh28ApEsi9wU/zuvQjqeOMoC633l/3UwsF
         1ppesuCW6Om7LGMgG4xSknb5e/KwXGo3StlZZ3Z6SMhsXWlD4ZY0l/s4oYZR88quLK1n
         0hu8dXdwT72IAp5y3O4ZeH9nW8nvJKEaQ0/Ey1IZm6MXw05bpzw+mz9HwtfYMTXMdyXU
         J3Gw==
X-Gm-Message-State: AC+VfDwxvTssuyE8nuItl2IbpdUttlw0znlWvAILyiHfev072SlpIhq5
        cBl2aMqUtYEvBYrp/bWp/MvImVkB32fnenQzwnDLLjAZdBvLUtZg1t1x8gcbNh+MGDatQqeCa/y
        WgsW1o6R6XqVTlrDXe1ixjzuAUouGf1BdjIp/
X-Received: by 2002:ac8:7f10:0:b0:3f4:fdaa:8e14 with SMTP id f16-20020ac87f10000000b003f4fdaa8e14mr24058168qtk.2.1685980504521;
        Mon, 05 Jun 2023 08:55:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5O9WI4eGMFyZs4w+vj++OK9goc6gtOc16upUEZKnKkx12mIS0AVqHYFJfLtAp2vyUQCLB11g==
X-Received: by 2002:ac8:7f10:0:b0:3f4:fdaa:8e14 with SMTP id f16-20020ac87f10000000b003f4fdaa8e14mr24058147qtk.2.1685980504283;
        Mon, 05 Jun 2023 08:55:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i8-20020ac871c8000000b003e69c51cf53sm4775373qtp.72.2023.06.05.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:55:03 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:55:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/11] selftests/mm: fix two -Wformat-security
 warnings in uffd builds
Message-ID: <ZH4FVkhxSB5g5RBN@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603021558.95299-7-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 07:15:53PM -0700, John Hubbard wrote:
> The uffd tests generate two compile time warnings from clang's
> -Wformat-security setting. These trigger at the call sites for
> uffd_test_start() and uffd_test_skip().
> 
> 1) Fix the uffd_test_start() issue by removing the intermediate
> test_name variable (thanks to David Hildenbrand for showing how to do
> this).
> 
> 2) Fix the uffd_test_skip() issue by observing that there is no need for
> a macro and a variable args approach, because all callers of
> uffd_test_skip() pass in a simple char* string, without any format
> specifiers. So just change uffd_test_skip() into a regular C function.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

