Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A01CA534
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEHHaZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgEHHaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 03:30:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E0C05BD09
        for <linux-kselftest@vger.kernel.org>; Fri,  8 May 2020 00:30:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d22so493739pgk.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 May 2020 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D3oWt1mR7W1fBju5sOZCALufL9LTYQI0+PIjjh/49vw=;
        b=g+lUGDLBGSWijIL9KUUhb2df2DC/dxrr4YW85noO/M5yoMhI6ZU/Autsip8G/fse6h
         uSKgvDtYUCRl4RPHGdBAg5MEz3RZGRDjFyhksTRzPkvd7GSX0ezgE8NPGWim3IvGDt3B
         J77MyE9NDGLWcl41ImtrN+Cr4dL9RHGZuw2no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D3oWt1mR7W1fBju5sOZCALufL9LTYQI0+PIjjh/49vw=;
        b=a6hZSUmVTTt+hAn2EE3oQVEkdct+O/DJqA4z/y5Yge3gR1xwJEXgzX0ZRK/A5y+dhE
         PDIkts7HlFpPQc8XgBU/JaqMPvlkOSrHF2o9B/vjYrBy/33QiSnWsMwBs2DBRzJvXkzM
         0SFvSsM8ELOnmAwlHk6MPc29AAgWw35vejHApTpLoSUf+CnQy7r/GZYvICmtEKJ8IAvH
         N4UL2gR+6jezk8WEjHsMU6Y23QzkWQG8AWJGJYhKdFuAxQ4iIpVUUD+i6EdGqoSiqaCr
         dSZky1IxUUy35nL/NzyI1bUuoG2cg84AjjJ6tMHuR78J9kEipMvJw/QUi9P+NU2TwZ4M
         avGQ==
X-Gm-Message-State: AGi0PuanRR/X/WktLea6Fq2uniPtcT88zyQQv4Yu+GiFN1iZhgLGOd58
        SWNAQuoHIS7q0fL86+8mOSvmhQ==
X-Google-Smtp-Source: APiQypIzaG1zsfaHvo9d7Ad2JjjHsm85REYliO9XUs9tK378O6fzUaHuGsllh/59F/+r2DvJ/RLsRQ==
X-Received: by 2002:a63:ef04:: with SMTP id u4mr1065970pgh.280.1588923023898;
        Fri, 08 May 2020 00:30:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e196sm873440pfh.43.2020.05.08.00.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 00:30:22 -0700 (PDT)
Date:   Fri, 8 May 2020 00:30:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/lkdtm: Use grep -E instead of egrep
Message-ID: <202005080030.93412F1F93@keescook>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <20200508065356.2493343-2-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508065356.2493343-2-mpe@ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 08, 2020 at 04:53:56PM +1000, Michael Ellerman wrote:
> shellcheck complains that egrep is deprecated, and the grep man page
> agrees. Use grep -E instead.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
