Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1E7798E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjHKUw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjHKUwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62D330DB
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691787097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8aVoixM0xxO+gfsUyyhZDp4bChNMHCVGjLRMPROvP8=;
        b=ND/zo0nfbyrtRPuOhDKVA89mjhP7jQ/8rPPwXm/ydLLvYZAGMrS1jlCMXrP6qVqp/yMhdc
        YpXEJa/3fXPMNheY6Ng7/wjbHVTjv8AH7/bHk0VZjOb9V18azI9IKNFOCPdyjhoMCfb3Hi
        MdUgI563ajbPd2qA89pZLO7KZULDgdI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-7FhJPhHpNWaL1-zEqfgUAQ-1; Fri, 11 Aug 2023 16:51:35 -0400
X-MC-Unique: 7FhJPhHpNWaL1-zEqfgUAQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-642efbdc73fso1739356d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 13:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787095; x=1692391895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8aVoixM0xxO+gfsUyyhZDp4bChNMHCVGjLRMPROvP8=;
        b=ag9QDxkz8ho6FI6XMbIMRd7YCvij5NejNwgW0xLk9nhl4qasa/15UoTUM/rtigK0xU
         Ajx+JFxiqXSWuy8E7uuVhgeDBhlXpdEsKGxgre6TxZIPKgNMzkEUY58cRvsw+1FsMDPH
         xCsA0DlXplI3M3YaZfPbgVfh9MLR7WFZvCEtPKOF631T365STVfbZ2UHbwyzXXPmYMYI
         QXRcJZT5it6W5mT+Uv1PJ65zA6GFaBwP4eB7G9haVPuGCGMch4tJQYYoS//8l+MbuXlT
         xF9N5PHubYecR30yy3S8Qbb/4mQt/DsXtcz9bM2WM06qKcncf6hKYG+I03ZNBzVjXRo1
         j58Q==
X-Gm-Message-State: AOJu0YwPmGrEccTYwiVZR/7avgiUCnbjkrNbSNpF7Q1j0Xd4E890ZXgd
        QieAUAGRhAXImzAqR1CHgx8urTR9CrpQPQDyxjV8Chr7n0wB+LIqU1URpiqFKg1n2xPISt2d4GV
        BPX1tLZwtaiOKCQlhUa4sDcSSGNvR
X-Received: by 2002:a05:6214:3002:b0:63f:7d29:1697 with SMTP id ke2-20020a056214300200b0063f7d291697mr3548985qvb.2.1691787094954;
        Fri, 11 Aug 2023 13:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsPsGGsWG+AWvL3NdKiHHIMNHgjAVmUCW2ANACa31+gfznIUk9YVZFCFV5mZXxugGUYOyp/w==
X-Received: by 2002:a05:6214:3002:b0:63f:7d29:1697 with SMTP id ke2-20020a056214300200b0063f7d291697mr3548975qvb.2.1691787094629;
        Fri, 11 Aug 2023 13:51:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id f8-20020a0caa88000000b00637873ff0f3sm1479316qvb.15.2023.08.11.13.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:51:32 -0700 (PDT)
Date:   Fri, 11 Aug 2023 16:51:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH mm-unstable fix] mm: userfaultfd: check for start + len
 overflow in validate_range: fix
Message-ID: <ZNafUoITDCuQOTMO@x1n>
References: <20230810192128.1855570-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810192128.1855570-1-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 12:21:28PM -0700, Axel Rasmussen wrote:
> A previous fixup to this commit fixed one issue, but introduced another:
> we're now overly strict when validating the src address for UFFDIO_COPY.
> 
> Most of the validation in validate_range is useful to apply to src as
> well as dst, but page alignment is only a requirement for dst, not src.
> So, split the function up so src can use an "unaligned" variant, while
> still allowing us to share the majority of the code between the
> different cases.
> 
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/linux-mm/8fbb5965-28f7-4e9a-ac04-1406ed8fc2d4@arm.com/T/#t
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

