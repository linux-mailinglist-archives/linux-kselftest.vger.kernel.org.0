Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2684138F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 19:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhIURqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 13:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhIURqT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 13:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632246290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6N8VBe8svoga5drgehLwNuhZWfQ1ETQys67yELw2/Tg=;
        b=KZDyWpp7mILh/P9knM218+b1XphrWmsrWhPHyZf9Y0rlWPNAqB0BLyoYat6rvlzjYVk4XW
        DzkthntFhZ4JlU2dCyPxwp+PF+hEKZ4YRNg/4pmwow+nolnrv0alRdCGbSE32uNOpYXsl4
        oPktlPPaBftd+Em0/U7YIBlFAm1vjuk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-VfAOgHIANjim6LDKLAkYwg-1; Tue, 21 Sep 2021 13:44:49 -0400
X-MC-Unique: VfAOgHIANjim6LDKLAkYwg-1
Received: by mail-qk1-f200.google.com with SMTP id m6-20020a05620a24c600b004338e8a5a3cso21647149qkn.10
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 10:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6N8VBe8svoga5drgehLwNuhZWfQ1ETQys67yELw2/Tg=;
        b=JNa0jkDuOrtuBSrMlLKwQqUML+PhYApGEY83R12jAoknxK1L34GsaA8GtrRPls4d05
         TZwWojng8+I3OqFd5JAkhl8VkGL300NjnExMckat047XGZzUHlH/bJbQ0LG+QdBAoJdc
         u/qaa2v1QvFYJEmNz/3RCx/0AUHwI8EfrK4TcpCberj79YThnwvYT9qJrx/0b0upXufF
         xYtbEp08VqTPKjcMmDrYxWkOZnhgh/WT3PayoYOPXvkW9zXV2CA3Avv2l2xhqZdyXg2h
         PBzKJbxjerK/NXffyHuEGMxbkmacswXT0S+M820qHkt3Yl8G824p0dgEV875wtzjhonK
         ZmdQ==
X-Gm-Message-State: AOAM532WD2bdQkecWvuS0IKZ/mKlipUfW1257QJ0qNLhC2r7oZG9xPIN
        LhsgOUJOHnWc3r2OSjIsUjOTtjMiqi2EYu+vMx3YlVYMyBkuF0MBerBGu9/pfCnb8veaLBQAVqA
        A1dZ76KTf83PIonkQZn151akSYAMr
X-Received: by 2002:ac8:c82:: with SMTP id n2mr28687283qti.207.1632246288973;
        Tue, 21 Sep 2021 10:44:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgQa6neroe9CMH682piLnpJaVS6v7I40G1JveuyTUzPPf5Wna6pHN4DAOUOCXGJxiczKobow==
X-Received: by 2002:ac8:c82:: with SMTP id n2mr28687257qti.207.1632246288683;
        Tue, 21 Sep 2021 10:44:48 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id z10sm4827915qtv.6.2021.09.21.10.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:44:48 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:44:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
Message-ID: <YUoaDr2wsW8wtk5Z@t490s>
References: <20210921163323.944352-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921163323.944352-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Axel,

On Tue, Sep 21, 2021 at 09:33:21AM -0700, Axel Rasmussen wrote:
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 10ab56c2484a..2366caf90435 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -79,10 +79,6 @@ static int test_type;
>  #define ALARM_INTERVAL_SECS 10
>  static volatile bool test_uffdio_copy_eexist = true;
>  static volatile bool test_uffdio_zeropage_eexist = true;
> -/* Whether to test uffd write-protection */
> -static bool test_uffdio_wp = false;
> -/* Whether to test uffd minor faults */
> -static bool test_uffdio_minor = false;

IMHO it's not a fault to have these variables; they're still the fastest way to
do branching.  It's just that in some cases we should set them to "false"
rather than "true", am I right?

How about we just set them properly in set_test_type?  Say, we can fetch the
feature bits in set_test_type rather than assuming it's only related to the
type of memory.

Thanks,

-- 
Peter Xu

