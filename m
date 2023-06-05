Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D1722B97
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 17:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjFEPnS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjFEPmy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 11:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92183196
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685979666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uft0/V/hdpGO50bCPjM3CiV+FvcYnCSQlJxLrPgoUA8=;
        b=O3rDcJEe5U+0Gix4JMir4dI2Yc1Iw4lY3r8C7Vl+3R02f0voe632ZsPXYdKW/bjSZJWRsf
        hw3tKPKc9Sr/JESaot5SYKn6qJ/QUI9Usq8FSlO+5RfUjRhH6i9JWVNM+VgjZH2GWsVFid
        VyWUYdmuX33JvAMCYsJHXr5EuPdTI0M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-XFPbnkWbPUKOpB8yCESkog-1; Mon, 05 Jun 2023 11:41:05 -0400
X-MC-Unique: XFPbnkWbPUKOpB8yCESkog-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f8b055287fso2431801cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 08:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979665; x=1688571665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uft0/V/hdpGO50bCPjM3CiV+FvcYnCSQlJxLrPgoUA8=;
        b=KTjyUGqnaMM0c3OAbFUuZ14KEUX0SOsfId+itLM62kKpiX5oPrxcRNTwbHkTGhD7w3
         hzU4WfNxeK23xrg3L8Z6ux6fXhyJiZP2fcdvjRwCDsfM/VomVLNfFi1qxDXZIeq3wZaX
         pymXWNhlW4m9CqgCP8pV9ESkHzIUMsYH2iN8V4T0cMWzVvxBOsatMpq6TPeIc8WvnW2h
         J/QeoifzxMUNdTKL0phJ+kcJJfo/XAg29nNW+ytW7kTQYQqKmR+FgNEHixEYMVen03sx
         Ebk/tDXil+YgZIc/uzL2Iowa0F0NGjTNEq08hOpuS1rHA46mkxZ9o/I1hhAT9sUsgwVi
         yqZw==
X-Gm-Message-State: AC+VfDzZ2fAeFIy+fvsqYOfDXzwUqbekQN/XvSOsKXE+XDfppgpPlItA
        x8UMC6kbQ7DeoKEq4PHqa5Mdc1N/4YxuTqp9nNE25PiVO729o7ucRkLaRE4u/UgrVNdg9cyHNPo
        GY0qGtqzeIvGkgHrV3nopG6cI6FuA
X-Received: by 2002:a05:622a:95:b0:3f9:ab19:714b with SMTP id o21-20020a05622a009500b003f9ab19714bmr1573735qtw.3.1685979665301;
        Mon, 05 Jun 2023 08:41:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6JOexwHI1evq4nWiluVsi0r15+oMcuWudqeNMtoU0/FALRbjWKt6iY9SHpYPWE2/xovsiUPg==
X-Received: by 2002:a05:622a:95:b0:3f9:ab19:714b with SMTP id o21-20020a05622a009500b003f9ab19714bmr1573725qtw.3.1685979665099;
        Mon, 05 Jun 2023 08:41:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87448000000b003e635f80e72sm4781861qtr.48.2023.06.05.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:41:04 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:41:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/11] selftests/mm: fix unused variable warnings in
 hugetlb-madvise.c, migration.c
Message-ID: <ZH4CDyV/dYItXfoP@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603021558.95299-3-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 07:15:49PM -0700, John Hubbard wrote:
> Dummy variables are required in order to make these two (similar)
> routines work, so in both cases, declare the variables as volatile in
> order to avoid the clang compiler warning.
> 
> Furthermore, in order to ensure that each test actually does what is
> intended, add an asm volatile invocation (thanks to David Hildenbrand
> for the suggestion), with a clarifying comment so that it survives
> future maintenance.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

