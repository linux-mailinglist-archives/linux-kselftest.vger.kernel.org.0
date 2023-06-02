Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B737205F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjFBPZz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 11:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjFBPZw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 11:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1D1B6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685719506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tf9XTi4m1mcrgHK3qjV3h4k5KcTMYkHl5NNGAMKEGNA=;
        b=CC/uC3GVndaYarkac3a4bW/FmeI3iBUmv1X5XJ644/oURJjV1LIZchepV6DHe36PZEuDrR
        Dg5QEvz7InCNffvKS7RojPyZdKxjGjIxtXOT7zlGX0AUXW5hfqGb05raL+pkQz/J26BinN
        lPS1264LCdt1qyNnG9lijKnGs7L50io=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-ELKfhZXMOOmxcAv3HgnfYw-1; Fri, 02 Jun 2023 11:25:05 -0400
X-MC-Unique: ELKfhZXMOOmxcAv3HgnfYw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-626204b0663so4722776d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 08:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685719504; x=1688311504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf9XTi4m1mcrgHK3qjV3h4k5KcTMYkHl5NNGAMKEGNA=;
        b=Va3/qw2RgRPCsvhGIXj5lbRF7FGAd86gnyXtYouk13z25wm2e+vQNyZmKWbJxpzssY
         e29/RZETg9IqQeiCx5f6mRQXxmN+g3750fNj/yqXWj94F3pI3W/qf6aTQasJk0xiaqw0
         X06TFUypDowm+ZeKz89AB65UQv8A6POO9fix9r611bULJCU/ISqABgOtSfNRz3kA1Lfb
         OXusCRHa6kLyoEiTLDB1cDhLqUZ/tIR9NWBZxyn3Uhh9IfjljaS+Tk6rO4Y2ddLdbl9u
         wE9nlP6wVxATv4M5T5x22EoZRX08RAoMKBuuT+nSSRygHMA4oQowC1pKXfzmg1B9HDwc
         qGGw==
X-Gm-Message-State: AC+VfDy7YrWOW3OA8HW16G+3Vr0K6wMMnwdXB8sLqR4ZhZp3y0wrPq8g
        Zoh88RJLbhT4DnBA2xOXPhMX59hy1bPnqdcKOa0Jg3lCAsfBbI/9sI04t184r79V86LaG2e9DJB
        c/XV+e0oQUZkTLgpU9LnFa2ufd8T/
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id f5-20020a056214076500b005edc96eca4amr10033224qvz.1.1685719504440;
        Fri, 02 Jun 2023 08:25:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HVJ6zVXHbrSuPEXRVVVl+vYEeh7Aot44vhghufKdcl9OcI7FYOwCXizswwMYA2eMjHbYEQQ==
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id f5-20020a056214076500b005edc96eca4amr10033208qvz.1.1685719504178;
        Fri, 02 Jun 2023 08:25:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id mg22-20020a056214561600b005ef5f8dc89esm933933qvb.88.2023.06.02.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:25:03 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:25:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] selftests/mm: fix uffd-stress unused function
 warning
Message-ID: <ZHoJzs4rP9NicJSP@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602013358.900637-2-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 01, 2023 at 06:33:47PM -0700, John Hubbard wrote:
> uffd_minor_feature() was unused. Remove it in order to fix the
> associated clang build warning.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

