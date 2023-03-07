Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9DC6AD3D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 02:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCGBYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 20:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGBYX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 20:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B755246
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 17:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678152220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqFd56y4+LzHfJxq40JHsrzkzmxYaLDJMh6dCS+VZKQ=;
        b=C0kAeLZ4m80kQ4W4REDmVUtUNvdH71ufoL66+MFJQcGyuqIkGfNppwFbe4jSHyzbvaQnyj
        t6xAqIUceq+fI32Pio566tw018E1mehq4s2XcmtiGgimP8DkQojH2Wr+koeHkdsho8PX2Y
        Imuov6DiiRJ8Uqa3mDmjklKLEbbdtCY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-a19QmaltOMKI-nUVm2fs2g-1; Mon, 06 Mar 2023 20:23:38 -0500
X-MC-Unique: a19QmaltOMKI-nUVm2fs2g-1
Received: by mail-qv1-f70.google.com with SMTP id y6-20020ad457c6000000b00535261af1b1so6651949qvx.13
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 17:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678152218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqFd56y4+LzHfJxq40JHsrzkzmxYaLDJMh6dCS+VZKQ=;
        b=NWM6R1uJMJxcJk4VjL0w4fqQXCD53P1F6zZaJiNUA9Tjkq8sOGWJZLZgLBp9afiJx1
         NldPGLIVZgcZT3cb2dWAHO0dLY2SSEyOxErQsF32Uiyu6++U9lo+Obw1eX3KfZk6Pimv
         OokDEjKxDLPJlapOikla/o7riOi6HORI1vrk9R7Uiq6A/pRpj/vzEBb6LptCh4AE4OdS
         MJVfRMhXsv4HAEokpFER3wZIeCAn7hI8bjRLrW5x89dal3y2aCbXaj2zNTs/94vVJyhl
         /EFnH/quAeMSV7UEo42m2jjCh7VBJ+C1lsok2OFeikeG59RsLbvjC13o8To+k/eqiOxT
         mCHg==
X-Gm-Message-State: AO0yUKXqt2PFy2rmcgzIrHymFrET00TKqVZuIPB9g2hcSLNfiSEADJ+n
        vfnmCd0LPq5BSCgbCn9nq0z1O6DrOfTNDUUF3C6ohqRG23is7NBe7D1nCm6B0yQ5UqLsJvall0r
        VwxEAARupG6A70qtnNWPYk5sMdxjE
X-Received: by 2002:ac8:4e49:0:b0:3b6:309e:dfe1 with SMTP id e9-20020ac84e49000000b003b6309edfe1mr22807061qtw.3.1678152218565;
        Mon, 06 Mar 2023 17:23:38 -0800 (PST)
X-Google-Smtp-Source: AK7set9NpW+IRYzeTwvzpjcmeG0lCpLiSMH4ix2ZZfLC9vuxmSNZLU9/wHTDN/VWK1ddDO5/7LNY8w==
X-Received: by 2002:ac8:4e49:0:b0:3b6:309e:dfe1 with SMTP id e9-20020ac84e49000000b003b6309edfe1mr22807045qtw.3.1678152218368;
        Mon, 06 Mar 2023 17:23:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id e15-20020ac85dcf000000b003bfad864e81sm8708948qtx.69.2023.03.06.17.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:23:37 -0800 (PST)
Date:   Mon, 6 Mar 2023 20:23:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 5/5] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to
 install WP PTEs
Message-ID: <ZAaSGGzylNFCR+ql@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306225024.264858-6-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 06, 2023 at 02:50:24PM -0800, Axel Rasmussen wrote:
> UFFDIO_COPY already has UFFDIO_COPY_MODE_WP, so when installing a new
> PTE to resolve a missing fault, one can install a write-protected one.
> This is useful when using UFFDIO_REGISTER_MODE_{MISSING,WP} in
> combination.
> 
> So, add an analogous UFFDIO_CONTINUE_MODE_WP, which does the same thing
> but for *minor* faults.
> 
> Update the selftest to do some very basic exercising of the new flag.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Some mentioning on the use case would be nice. :) No objection having it.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

