Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8A3DF97C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 04:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhHDCAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 22:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhHDCAT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 22:00:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0307DC061764
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Aug 2021 19:00:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gs8so1314444ejc.13
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Aug 2021 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnuZs/g8Oew5RJJwXI/t9ztON31nLnDM5yCpxcP3G5Y=;
        b=M+OBkl7Ni519XngieCIV8Nw7Z3EiKgKSxTlp7loQj9h9rhj3+EAkRpflcKTj02vYCr
         T+a5qt2T4XvSU2J3rpwVHUGXIabN167Bq1GNqy/pNlomMwnmc+iG3CxMGxZhV8JVMaLf
         woHlclSeqZP9UqG8RTivp2FtSH94w/Ul8yTnYGkz4RRRzH/ZIzRNoPP4PNX5Ei+d0uGb
         ZlHPg9s7oF50/OtM7981W/R0vLRyp9zy6jix2xvKjKH4ShnHXbuURbvJEOqe11u52OGi
         ckXT2tKfpC/o4vJKAhjZxRd2UIFXlWpCYEF21knP9FNOvsLefIHvzg8JD62mSiEtMh4M
         X63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnuZs/g8Oew5RJJwXI/t9ztON31nLnDM5yCpxcP3G5Y=;
        b=Xs9l8TbzEczgTArFvQC3/RaQpixWARl7DEK8mGSYNMCOyNrcTvJVNXdYe2Qbr3yKTU
         T8/C3IyfFHFTdo3r9NOvDIOk4/OzCBTgqUAa9evHJqkA+I4etEPk0/CFP8mgwVb1EZT+
         Gmr6wJo7moXgYDY5z/wv189XZPjukvdw2teiwKiOBIkY/6tQrbadyNqb2q99LayKr6gl
         aSlOV9CTBwcIWxSqg6jVNNyMRbeGUcHM6tsIbvElJJe+1UZ3tOhEoG2qN9+1FgNikBTq
         NmOh8Xqh53ZTQ90D411b+NxhyULIpRCkSeQlf0Rj7dh2G/uX3O7mo+sBKU2pLeDOPZLT
         hG4w==
X-Gm-Message-State: AOAM532IdClFQr46qV4yN/11rS7y5LTijLMj2/7LHcxZKD2Bhp0jOzbG
        pwgDVbVItsX2Q0xMXoUbVF+7yYpw932Z6Q758vq80A==
X-Google-Smtp-Source: ABdhPJzrmInWA81g9WZA9syNr4nSHk73VmvWHU0el4ZKHkRh7fMDg0SGz0UdWcEWP/UM/q3b7HX/cmf3n+i0tYBAYck=
X-Received: by 2002:a17:906:d20a:: with SMTP id w10mr24376079ejz.426.1628042406564;
 Tue, 03 Aug 2021 19:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com> <6d0caab00d4bdccf5e3791cb95cf6dfd5eb85e45.1626252248.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <6d0caab00d4bdccf5e3791cb95cf6dfd5eb85e45.1626252248.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 3 Aug 2021 21:59:30 -0400
Message-ID: <CA+CK2bCwuDG+LRU_im-N=iZzomNntmreABjg3K5hFFB9o8LgKA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selftests: vm: add KSM zero page merging test
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     shuah@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 14, 2021 at 4:56 AM Zhansaya Bagdauletkyzy
<zhansayabagdaulet@gmail.com> wrote:
>
> Add check_ksm_zero_page_merge() function to test that empty pages are
> being handled properly. For this, several zero pages are allocated and
> merged using madvise. If use_zero_pages is enabled, the pages must be
> shared with the special kernel zero pages; otherwise, they  are merged
> as usual duplicate pages. The test is run as follows: ./ksm_tests -Z
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
