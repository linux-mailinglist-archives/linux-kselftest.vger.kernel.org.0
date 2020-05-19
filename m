Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133CE1DA324
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 22:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgESU5c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 16:57:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725998AbgESU5c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 16:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589921851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwz7jvP7QJxpslix8nB23gtXBXiGZ+Spq3gPyIC1L7w=;
        b=i88Bv9uyuqizvslQeTZBWfxrt5GlWSdoP2QgdhlPBN0w42iummFg7bFOmWSRzN5BNiUzTR
        MtcDr+WCkVbWHWt50HNX/diR5L/2MB8/GMDzZ/j21LZWaSOb830goJ1SekQJ7t8Y0HPlNK
        Byd3dz6PCumN9S2uSNUlhIT4YrxDFi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-uwMhzxpZMAy_YDq2yEunyA-1; Tue, 19 May 2020 16:57:29 -0400
X-MC-Unique: uwMhzxpZMAy_YDq2yEunyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 728F0107ACF2;
        Tue, 19 May 2020 20:57:28 +0000 (UTC)
Received: from localhost (unknown [10.36.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C3E11000322;
        Tue, 19 May 2020 20:57:26 +0000 (UTC)
Date:   Tue, 19 May 2020 22:57:22 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests: introduce gen_tar Makefile target
Message-ID: <20200519225722.49e4d067@redhat.com>
In-Reply-To: <20200519200045.317516-1-vkabatov@redhat.com>
References: <20200519200045.317516-1-vkabatov@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 May 2020 22:00:45 +0200
Veronika Kabatova <vkabatov@redhat.com> wrote:

> The gen_kselftest_tar.sh always packages *all* selftests and doesn't
> pass along any variables to `make install` to influence what should be
> built. This can result in an early error on the command line ("Unknown
> tarball format TARGETS=XXX"), or unexpected test failures as the
> tarball contains tests people wanted to skip on purpose.
> 
> Since the makefile already contains all the logic, we can add a target
> for packaging. Keep the default .gz target the script uses, and actually
> extend the supported formats by using tar's autodetection.
> 
> To not break current workflows, keep the gen_kselftest_tar.sh script as
> it is, with an added suggestion to use the makefile target instead.
> 
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

