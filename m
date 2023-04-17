Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864466E4C45
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDQPBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDQPBk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 11:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D852135
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681743629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLT0rP9zRrFGagsk4no7XW+N43K0c6wa29Y33hfsxZA=;
        b=Se17SZmqN5XuI/wYq38EuCdMWVtaJN3+9L2TLB7YdIuwtsd4NE36BAPhLsa4O0DNaBXLB3
        QQVGZ0ER3F+fqiHGOKpmiBqdIJ6XrZF/rwBTgF+kLSuYEF5Rmu0YhxgWMWZojzaN79nA/W
        nR5XGLr1p7+TpRLFDq0GT/1hFlzhQRQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-hjsUrGkgM7anrqFRJJPyrA-1; Mon, 17 Apr 2023 11:00:27 -0400
X-MC-Unique: hjsUrGkgM7anrqFRJJPyrA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f1763fac8bso2506695e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 08:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743626; x=1684335626;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLT0rP9zRrFGagsk4no7XW+N43K0c6wa29Y33hfsxZA=;
        b=PjQ05aG1nvRD+G/cAicIqMrU0hyZ08CZDdBOSZUyjohTB5QyqR9qedpxa5ZpkNojwz
         hQEgl3Rbc5DBwOhu5EBL5ExxX+PgrrsMuThaeY1O6ECf/85QMwU712CNkD6ajEih/nTr
         tp47jQoP/2noGn13phbBO2FYuKwh/hv2zUZzUZcXfiDEoDrnpt4B53ouR/ABdxHbYXqz
         jOh7rwJ7dNIGli+gF4gwqFIFqGfvoPoOp6kt5wg2seiCRIOoeEaINYk/f8jrZO3qKE7c
         qkB9UhtmDo40nzcuLyuvQF9QI0nQNOzOIxz2jh+CGBFb2o67ggiJw/bMtRf9ZMBcoPSr
         XXag==
X-Gm-Message-State: AAQBX9d55zjnfarW/B2DQmA9VtPU2y4Xm5E55PWnHYWtu4Onp8ve/2EF
        bMTN+3N0dSdIFBHn97/Lr9jOpWEOGf6WAs9NN47OfLsibiUiEjuVDaYGEramVn7FLwkam2LAeGL
        zpBoM6PaD8ioQCNHraB5a4Yu6G4Kk
X-Received: by 2002:adf:ed4c:0:b0:2f5:3dfd:f4d2 with SMTP id u12-20020adfed4c000000b002f53dfdf4d2mr5640104wro.64.1681743626554;
        Mon, 17 Apr 2023 08:00:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350YsKOxwZX6am7dDPrBSxeyriaPLE8HJ1zejtvMwWin7cKY8fooXz/gsbQvRu662UxNAvKAkdA==
X-Received: by 2002:adf:ed4c:0:b0:2f5:3dfd:f4d2 with SMTP id u12-20020adfed4c000000b002f53dfdf4d2mr5640088wro.64.1681743626208;
        Mon, 17 Apr 2023 08:00:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6b09000000b002d97529b3bbsm10671612wrw.96.2023.04.17.08.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:00:25 -0700 (PDT)
Message-ID: <b9f1fd7f-e362-8f6c-21db-e84dd82fdd00@redhat.com>
Date:   Mon, 17 Apr 2023 17:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 1/3] mm: add new api to enable ksm per process
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230415225913.3206647-1-shr@devkernel.io>
 <20230415225913.3206647-2-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230415225913.3206647-2-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> +static void __ksm_add_vma(struct vm_area_struct *vma)
> +{
> +	unsigned long vm_flags = vma->vm_flags;
> +
> +	if (vm_flags & VM_MERGEABLE)
> +		return;
> +
> +	if (vma_ksm_compatible(vma)) {
> +		vm_flags |= VM_MERGEABLE;
> +		vm_flags_reset(vma, vm_flags);
> +	}
> +}

We can do the following simplification on top:

diff --git a/mm/ksm.c b/mm/ksm.c
index 905c8edce5cf..26e7f585d65d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2511,15 +2511,11 @@ static int ksm_scan_thread(void *nothing)

  static void __ksm_add_vma(struct vm_area_struct *vma)
  {
-	unsigned long vm_flags = vma->vm_flags;
-
-	if (vm_flags & VM_MERGEABLE)
+	if (vma->vm_flags & VM_MERGEABLE)
  		return;

-	if (vma_ksm_compatible(vma)) {
-		vm_flags |= VM_MERGEABLE;
-		vm_flags_reset(vma, vm_flags);
-	}
+	if (vma_ksm_compatible(vma))
+		vm_flags_set(vma, VM_MERGEABLE);
  }

  /**
-- 
2.39.2


I have some patches based on your patch set (handling/testing unmerging 
whens setting PR_SET_MEMORY_MERGE=0. Will send out once you changes are 
queued.

-- 
Thanks,

David / dhildenb

