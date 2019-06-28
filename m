Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93F55995C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2019 13:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfF1Lo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jun 2019 07:44:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfF1Lo6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jun 2019 07:44:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D471159466;
        Fri, 28 Jun 2019 11:44:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A32A25DA97;
        Fri, 28 Jun 2019 11:44:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3B9A011AA3; Fri, 28 Jun 2019 13:44:41 +0200 (CEST)
Date:   Fri, 28 Jun 2019 13:44:41 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
        daniel.vetter@ffwll.ch, laurent.pinchart@ideasonboard.com,
        tomeu.vizoso@collabora.com, airlied@linux.ie, shuah@kernel.org
Subject: Re: [PATCH] selftests: dma-buf: Adding kernel config fragment
 CONFIG_UDMABUF=y
Message-ID: <20190628114441.agosvv3ziujhzqbf@sirius.home.kraxel.org>
References: <20190628104148.5314-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628104148.5314-1-naresh.kamboju@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 28 Jun 2019 11:44:58 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 28, 2019 at 11:41:48AM +0100, Naresh Kamboju wrote:
> The test case drivers/dma-buf/udmabuf need this kernel config enabled
> 
> CONFIG_UDMABUF=y
> 
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

> ---
>  tools/testing/selftests/drivers/dma-buf/config | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/drivers/dma-buf/config
> 
> diff --git a/tools/testing/selftests/drivers/dma-buf/config b/tools/testing/selftests/drivers/dma-buf/config
> new file mode 100644
> index 000000000000..d708515cff1b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/dma-buf/config
> @@ -0,0 +1 @@
> +CONFIG_UDMABUF=y
> -- 
> 2.17.1
> 
