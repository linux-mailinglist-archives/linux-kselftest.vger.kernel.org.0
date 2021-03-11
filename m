Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6CE3380A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 23:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCKWhq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Mar 2021 17:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCKWhf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Mar 2021 17:37:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF6C061574;
        Thu, 11 Mar 2021 14:37:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x21so5218745eds.4;
        Thu, 11 Mar 2021 14:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fXghSk9caRWFDRCz6fZq581zxQ1h0J2EoY5DSpAlgro=;
        b=lMzrbplLg4M4wJocvzEGEBYyWixVqH6cGi7JRgMkjT5Q/UszF26rY9VgsY7RA/0Uhk
         GG/zYoTnqi0bwp+7ppeaR+OMjOKN6P6O52IlKBgqIsnVHp3j8B0Uq4OwDAp4i9xU4RbZ
         cJcDc8sXYq/qem8W4zpOklI4ZJJH3iT2/RvdkM7OtjEIwW0xCQ2gS6jUGd+eAhVnsad0
         J0MqZi9YXlC3DQ9nYgiWP5TKUcCSScSztJVDtVXZ0KMSa4qLHfsEE9duAnDqLDy9Ft5b
         RccCUkWjb7HE2TBAOksJx0gIzv4HfD8EWVuaxwZ9VJ2xyfB2K8bPzKAAw4Qm8AyzGcsR
         MbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fXghSk9caRWFDRCz6fZq581zxQ1h0J2EoY5DSpAlgro=;
        b=gHQtj7b8O7WJeupAYluqbdsekqvsbuUpnUQ5wE3/ZK47SipLTdBOMywZP4HWlp5vFD
         0DWt0VNFjW7ImDFNJTt5irCwclg1z79LZqKCjsLO+6NVPRzpYZJEZtF6qvx0r7mEfuST
         HzMZbFKfWN54Wk5XfnY3ebBRNLNxEBUiehaaL2drgwOwhg3lWQc5D9KAJwbd7McfRo+y
         mSHYf9onYAtPrqg0AH9X0rcd1nJTvP+FiOeDz7VOSf5izELjcHQC8WzDuwcAt5ytmEWm
         ARV6GoNQFZnFQPM/tFY5O0BgMPT/OuyLzCm9RG3QWTihTOQcphVeVUocueOFXxZmGZrF
         aRYQ==
X-Gm-Message-State: AOAM53236j/+tYxWjkpLkA9q21+vnL4Wx98o9oy24HEU+RTP7IpPakUL
        8n8C+3AKqqxXojEwZUuT0BxPjMEYA+E92EBONgw=
X-Google-Smtp-Source: ABdhPJzVKFYwSspdbEbBYCUOrZiXSEa8rHyVbd8LQ3zNjc4/aqAS0jN39CO9lHjA8rtfPUHdepo15UrmW+1WvpfqYE8=
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr10774827edd.168.1615502253659;
 Thu, 11 Mar 2021 14:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20210310153544.434160-1-zi.yan@sent.com> <CAHbLzkqaGqW8_dmR=PBojEVFGU+FfUm2Y+Rhu0Ay8aP1cAChdA@mail.gmail.com>
 <A3A1CBF3-B5D2-4CF2-97D6-9BC12E82BEAE@nvidia.com>
In-Reply-To: <A3A1CBF3-B5D2-4CF2-97D6-9BC12E82BEAE@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 11 Mar 2021 14:37:21 -0800
Message-ID: <CAHbLzkpLhMkHW5JYu2K2XTgoGBjUcvR6u0iTT5UYyYHU3YDz_A@mail.gmail.com>
Subject: Re: [PATCH v2] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Mika Penttila <mika.penttila@nextfour.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 11, 2021 at 7:52 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 10 Mar 2021, at 20:12, Yang Shi wrote:
>
> > On Wed, Mar 10, 2021 at 7:36 AM Zi Yan <zi.yan@sent.com> wrote:
> >>
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> We do not have a direct user interface of splitting the compound page
> >> backing a THP and there is no need unless we want to expose the THP
> >> implementation details to users. Adding an interface for debugging.
> >>
> >> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> >> <debugfs>/split_huge_pages_in_range_pid, THPs within the given virtual
> >
> > Can we reuse the existing split_huge_page knob instead of creating a ne=
w one?
> >
> > Two knobs for splitting huge pages on debugging purpose seem
> > overkilling to me IMHO. I'm wondering if we could check if a special
> > value (e.g. 1 or -1) is written then split all THPs as split_huge_page
> > knob does?
> >
> > I don't think this interface is used widely so the risk should be very
> > low for breaking userspace.
>
> Thanks for the suggestion.
>
> I prefer a separate interface to keep input handling simpler. I am also
> planning to enhance this interface later to enable splitting huge pages
> to any lower order when Matthew Wilcox=E2=80=99s large page in page cache=
 gets in,
> so it is better to keep it separate from existing split_huge_pages.

The input handling seems not that hard, you might be able to try to do:

ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start,
&vaddr_end, order);
switch(ret) {
case ret =3D=3D 1:
                split_all_thps
case ret =3D=3D 3:
                 split_thp_for_pid
case ret =3D=3D 4:
                 split_thp_for_pid_to_order
default:
                 return -EINVAL
}

Will it work for you?

>
> =E2=80=94
> Best Regards,
> Yan Zi
