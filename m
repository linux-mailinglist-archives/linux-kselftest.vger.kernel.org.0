Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815CF6EF7EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbjDZPry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 11:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbjDZPrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 11:47:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED8B4ECA
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 08:47:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a9290a6f96so231695ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682524072; x=1685116072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icRqAe7nXXoFe5wBtlTPQGzEz5lTajsqdZLBPsXJ7Ww=;
        b=1kUsEkYDmAiZHwWxcCKrKKKOeMDYq2Y7K3oLzlciFgpheZtCxILkGhlvF3Cp2UndY/
         io2PMoe8Ky0DQmv0TYJoks+L+UzPezu8LObCEtS28GiSObi7aC4ljJdOm37ovf1R48+e
         q49Y7OPNb68onBjp42GNDzw2qC7hJx0LKt2nWokSzn+NwiboPSaY+JjDYbgW4v6gyt19
         GtD699pFgSrogm5HOC3NKCccYp1/hFxc1oKf5z8HHa/bJ2Q4BKNYkDVAyEn8NWru/PfI
         z1bj0pZyxaw9KKL4si7dpwJBVEeOsEC6Rn7BsiJ3ayx+tPH8aOT5pRNSRAGHccULS5v5
         rRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682524072; x=1685116072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icRqAe7nXXoFe5wBtlTPQGzEz5lTajsqdZLBPsXJ7Ww=;
        b=Xjkw+Tp1hOwmch9I8Psl+/iFljgIE6y/+TL4dgjRfcGdBTNscFRZD+ONqvPmUJ8g14
         md/dpTID6fmLuRetEM9d3d80a4K+yNFBmvfJSkup8ISaIo/lUsmuhivOGFEN9pVPE2vY
         L8zaQLQnQWHP33Q5w94WShx/DraA9nCEAmBmHrMIE8Yi9Rv2HOpPow8Y1ezG/dw1Fr5y
         tjUGvyRn+21A887inUbm2Gxl1WUID+Gf/ZDHRqpIHo+2rnKnlq38LsAhgxUH7MkgMlOA
         c8U5N3ybIGB1sMnWv4OqUnb3YkmURWDdHZBBogYaiAeLaAdh6fCyNUNT3OqflNnuTFNL
         8ryg==
X-Gm-Message-State: AC+VfDyrLLid9ShZozrvS/+ogvFDAxMtQVdj6U2DTBEnK+gQeikxneiI
        N5/K9nOOVP6w/aEBOFklE7uurtHubObjGTx5rWr+MQ==
X-Google-Smtp-Source: ACHHUZ6ARCXcbIQ0cs8zaF3y7UAgEM1sBv+gXAuwRFBBtBsIYLcvAS8vZDH689g2xg7rcARcqBjiXAXeoEKf/f34Kn4=
X-Received: by 2002:a17:903:234e:b0:1a6:d776:9628 with SMTP id
 c14-20020a170903234e00b001a6d7769628mr233511plh.19.1682524071958; Wed, 26 Apr
 2023 08:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-4-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230413034108.1902712-4-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 26 Apr 2023 08:47:39 -0700
Message-ID: <CAAH4kHb_PAhR5jLFi2KsGku9ALNtjtxb-JO-k1ULK-Mj5mi=pw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests/tdx: Test GetQuote TDX attestation feature
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 12, 2023 at 8:42=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> In TDX guest, the second stage of the attestation process is Quote
> generation. This process is required to convert the locally generated
> TDREPORT into a remotely verifiable Quote. It involves sending the
> TDREPORT data to a Quoting Enclave (QE) which will verify the
> integerity of the TDREPORT and sign it with an attestation key.

nit: integrity

>
> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> allow user agent get the TD Quote.

nit: to get
>
> Add a kernel selftest module to verify the Quote generation feature.
>
> TD Quote generation involves following steps:
>
> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> * Embed the TDREPORT data in quote buffer and request for quote
>   generation via TDX_CMD_GET_QUOTE IOCTL request.
> * Upon completion of the GetQuote request, check for non zero value
>   in the status field of Quote header to make sure the generated
>   quote is valid.
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>  tools/testing/selftests/tdx/tdx_guest_test.c | 68 ++++++++++++++++++--
>  1 file changed, 62 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing=
/selftests/tdx/tdx_guest_test.c
> index 81d8cb88ea1a..2eccde54185b 100644
> --- a/tools/testing/selftests/tdx/tdx_guest_test.c
> +++ b/tools/testing/selftests/tdx/tdx_guest_test.c
> @@ -18,6 +18,7 @@
>  #define TDX_GUEST_DEVNAME "/dev/tdx_guest"
>  #define HEX_DUMP_SIZE 8
>  #define DEBUG 0
> +#define QUOTE_SIZE 8192
>
>  /**
>   * struct tdreport_type - Type header of TDREPORT_STRUCT.
> @@ -128,21 +129,29 @@ static void print_array_hex(const char *title, cons=
t char *prefix_str,
>         printf("\n");
>  }
>
> +/* Helper function to get TDREPORT */
> +long get_tdreport0(int devfd, struct tdx_report_req *req)
> +{
> +       int i;
> +
> +       /* Generate sample report data */
> +       for (i =3D 0; i < TDX_REPORTDATA_LEN; i++)
> +               req->reportdata[i] =3D i;
> +

Shouldn't req be zeroed before populating reportdata? We wouldn't want
uninitialized memory to leave the guest. I know this is just a test,
but it's best to model good practices for anyone that might
copy/paste.

> +       return ioctl(devfd, TDX_CMD_GET_REPORT0, req);
> +}
> +
>  TEST(verify_report)
>  {
>         struct tdx_report_req req;
>         struct tdreport *tdreport;
> -       int devfd, i;
> +       int devfd;
>
>         devfd =3D open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
>         ASSERT_LT(0, devfd);
>
> -       /* Generate sample report data */
> -       for (i =3D 0; i < TDX_REPORTDATA_LEN; i++)
> -               req.reportdata[i] =3D i;
> -
>         /* Get TDREPORT */
> -       ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT0, &req));
> +       ASSERT_EQ(0, get_tdreport0(devfd, &req));
>
>         if (DEBUG) {
>                 print_array_hex("\n\t\tTDX report data\n", "",
> @@ -160,4 +169,51 @@ TEST(verify_report)
>         ASSERT_EQ(0, close(devfd));
>  }
>
> +TEST(verify_quote)
> +{
> +       struct tdx_quote_hdr *quote_hdr;
> +       struct tdx_report_req rep_req;
> +       struct tdx_quote_req req;
> +       __u64 quote_buf_size;
> +       __u8 *quote_buf;
> +       int devfd;
> +
> +       /* Open attestation device */
> +       devfd =3D open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
> +
> +       ASSERT_LT(0, devfd);
> +
> +       /* Add size for quote header */
> +       quote_buf_size =3D sizeof(*quote_hdr) + QUOTE_SIZE;
> +
> +       /* Allocate quote buffer */
> +       quote_buf =3D malloc(quote_buf_size);
> +       ASSERT_NE(NULL, quote_buf);
> +
> +       quote_hdr =3D (struct tdx_quote_hdr *)quote_buf;
> +
> +       /* Initialize GetQuote header */
> +       quote_hdr->version =3D 1;
> +       quote_hdr->status  =3D GET_QUOTE_SUCCESS;
> +       quote_hdr->in_len  =3D TDX_REPORT_LEN;
> +       quote_hdr->out_len =3D 0;
> +
> +       /* Get TDREPORT data */
> +       ASSERT_EQ(0, get_tdreport0(devfd, &rep_req));
> +
> +       /* Fill GetQuote request */
> +       memcpy(quote_hdr->data, rep_req.tdreport, TDX_REPORT_LEN);
> +       req.buf   =3D (__u64)quote_buf;
> +       req.len   =3D quote_buf_size;
> +
> +       ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_QUOTE, &req));
> +
> +       /* Check whether GetQuote request is successful */
> +       EXPECT_EQ(0, quote_hdr->status);
> +
> +       free(quote_buf);
> +
> +       ASSERT_EQ(0, close(devfd));
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.34.1
>


--=20
-Dionna Glaze, PhD (she/her)
