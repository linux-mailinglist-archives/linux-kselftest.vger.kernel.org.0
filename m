Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62C1774D62
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 23:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjHHVxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHHVxJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 17:53:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500E091241;
        Tue,  8 Aug 2023 10:32:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BFE2A5C009D;
        Tue,  8 Aug 2023 13:32:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 08 Aug 2023 13:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691515924; x=1691602324; bh=rM
        UaHZaSAI4l93e7AeZWrkXodMmRgdTWwjGdICmzDaY=; b=QIb8cGi7i1UpCeFo5r
        lPDUKHa3UY9ysLj4xsmXkoQgvBnocxeYG0J5izW/BE4h7jAd0iuMvoFXviIVuqjU
        klbeJ0cZ8iy+M0HSct94mQUeO5Anw0ggFpYldatqYosC+89HxfY4nRT2YxEwZ87N
        AUa032AxMKzHx3eOvh/u8IzjecbYVvlnIzVdGqs9PdD/Vjj0AYzNjyRK5GoGoghU
        YzvDY5hvLZOvbYdJXEhDPqjPbnOt9pIAIj1lFWq+DPxlbT2/6y5yuaF9kWuKSexX
        bbxGShvrwZaCorxqbR4fQ1X553N6umvdv5D2sIt373aRzFqA4rHe5VrG9ZQqBXF5
        i56g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691515924; x=1691602324; bh=rMUaHZaSAI4l9
        3e7AeZWrkXodMmRgdTWwjGdICmzDaY=; b=l7U6RjUGhd233kTpEmkm+1CLdkldm
        P/2Bkl4+Awfzq9S1G9OmEPBEy+17nWwdTGB4KB18+fV+EFau+oDwheZDXD2FyPb5
        zSGkfWbcI5YIyZcV9ligquRd8/vW/gdugihmSiZQMDAEUQYvwv2Wb1DxOdpog+DD
        0gnFnOGvfevxWVD0eQ+2GapGhe8QOdDe7bTDCqvje3wDMcwzlPJPFlk8NxvfsT2J
        nXM9C0cIQjlBuspJUlHzmkjyjAvaSlO0+JvfMMdnCS3OYa7YBjKIOR2/sElWcFXe
        O/7mfnzROWwl3puMBQXllZdeMhRIxCjAeSZvrP00SpXm8tVF6IdrW1x4A==
X-ME-Sender: <xms:FHzSZMTGHEnq7zDK1mIf5aLNFwb-rsYwg34gMlfZrRrosCiTnUUzGA>
    <xme:FHzSZJzVeniscGdjhruJMk1lVnAJa1Z81GpRZLlOULuY1vPspgjeAhT3JvgUQPUYB
    RnEELaBVO9M0_eRKPk>
X-ME-Received: <xmr:FHzSZJ1zZ9PeCvuflHXT4OGmzhHugInOtK-hxKlOQLlTyf9wKX2m4SknA5x72tgHwrUSjjRNDYUy6Fmd-rIzOIYrFVCOE58151IDrfL5HCjn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghf
    rghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrth
    htvghrnhepveelgffghfehudeitdehjeevhedthfetvdfhledutedvgeeikeeggefgudeg
    uedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:FHzSZAC0ivTxstdOr3eWUaee0pkAovRjRbMc_Bvxe6iBw2ViHBBH5g>
    <xmx:FHzSZFhoCulsZuDMQnDf0QX8RnXxp-vDECZNYiceJ-rKjCylbKZfHw>
    <xmx:FHzSZMoZNJWXhrGmrXm5ALc1DBlfE3uRX6Hd-Vu2maNn3B-0Q3H2iw>
    <xmx:FHzSZAozjPgXYOkeAjtH_oqX0kF4XAk7otsZsyd0Md4QNHXHdDcx_Q>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 13:32:03 -0400 (EDT)
References: <20230728163952.4634-1-ayush.jain3@amd.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Ayush Jain <ayush.jain3@amd.com>
Cc:     akpm@linux-foundation.org, shuah@kernel.org,
        pasha.tatashin@soleen.com, zhansayabagdaulet@gmail.com,
        tyhicks@linux.microsoft.com, raghavendra.kt@amd.com,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Narasimhan.V@amd.com,
        Santosh.Shukla@amd.com, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/2] selftests: mm: ksm: Fix incorrect evaluation of
 parameter
Date:   Tue, 08 Aug 2023 10:31:24 -0700
In-reply-to: <20230728163952.4634-1-ayush.jain3@amd.com>
Message-ID: <qvqwfs4tphip.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Ayush Jain <ayush.jain3@amd.com> writes:

> A missing break in kms_tests leads to kselftest hang when the
> parameter -s is used.
> In current code flow because of missing break in -s, -t parses
> args spilled from -s and as -t accepts only valid values as 0,1
> so any arg in -s >1 or <0, gets in ksm_test failure
>
> This went undetected since, before the addition of option -t,
> the next case -M would immediately break out of the switch
> statement but that is no longer the case
>
> Add the missing break statement.
>
> ----Before----
> ./ksm_tests -H -s 100
> Invalid merge type
>
> ----After----
> ./ksm_tests -H -s 100
> Number of normal pages:    0
> Number of huge pages:    50
> Total size:    100 MiB
> Total time:    0.401732682 s
> Average speed:  248.922 MiB/s
>
> Fixes: 07115fcc15b4 ("selftests/mm: add new selftests for KSM")
>
> Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
> v1 -> v2
> collect Reviewed-by from David
> Updated Fixes tag from commit 9e7cb94ca218 to 07115fcc15b4
>
>  tools/testing/selftests/mm/ksm_tests.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
> index 435acebdc325..380b691d3eb9 100644
> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -831,6 +831,7 @@ int main(int argc, char *argv[])
>  				printf("Size must be greater than 0\n");
>  				return KSFT_FAIL;
>  			}
> +			break;
>  		case 't':
>  			{
>  				int tmp = atoi(optarg);

Acked-by: Stefan Roesch <shr@devkernel.io>
