Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ACA6DDEFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjDKPJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDKPJJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 11:09:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1D3ABF
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 08:08:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q23so11761440ejz.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681225724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CKtT5Jvf3f0JgKYZh7PXFqhEMkaUpMPr+pEhO6IQ30=;
        b=L4f4rl0cnkxJoP0/ReN7wsAGlmTTMsW0Yid+qhHquTtauzUtz9uoaqBMWJOSc1s6f+
         k9y/UrAki3869xJUZXC2DJHg7qCUcnxDBU6FzuY8k5QzlVSjISZMCnfEt0vIwvoaAj0k
         rUn5E6g57n/D1EcfV7g26SZbv43MRsWsr6MCXOKcet5UXADhqqVQe2SU7ArZWXtd1koQ
         wa76Fs/5DvIne1g0uZ5VJRMPWqusM0iKuIbLJZKC5gxtmbDgn6E7HiuEjQYQ5EU3q6sk
         xN+7HHAJUAEni/wVLSoTduKPHJzfuMF/BfEFHerR0bBZ24LmcT/nEXm9LekkvjZJKSoO
         5vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CKtT5Jvf3f0JgKYZh7PXFqhEMkaUpMPr+pEhO6IQ30=;
        b=aSp8OfUDFD+TCWqYcP1pXiXl/VgVtjTOMvDL+UZgeSP1J4h/Gy8kInWz48clyXXua+
         Dgvc8agToYmfrpr9wVY+ORQ+ybGE0yAG3gTS/HzVNQ4VK/8WkuLRCLebPGArHIqLBM/B
         cHQYdTUKPqNlxTl8qDVn6eiiAypWUSfolchpxaon8YPGjrQHAEhHzGf8u/EyVeQ6+iyv
         wiPy+7siEmwM974iIgi790vWEuC3MJ5048Obc+WD4hYxUr+CHzx+dy67fRNQTt01bPLa
         WHv7/bOiRSKeMJyM2VxH8fbx+IsvRLe5FAxGiQJOrvT3hTKMfG/TCUgJ14yGyHeeJxGX
         93eg==
X-Gm-Message-State: AAQBX9e2zN4U9GKMVULgcvkNOH7Mkama1FWS9C+iCxTuw2bqeQQXyJgH
        E+8zDJhQdPMyVnGeOQLBzB/KB+ekEtC0V0ESrWg/yw==
X-Google-Smtp-Source: AKy350arniCGBsMeQ/B/9V1F5ZCcTIUWRYoaxrt/sLV/Wbp04zqFjFkuKph/IMSp06UofYm5hMkq/SUhexA3pnq2IHw=
X-Received: by 2002:a17:907:7f23:b0:94a:8300:7246 with SMTP id
 qf35-20020a1709077f2300b0094a83007246mr3468304ejc.14.1681225723956; Tue, 11
 Apr 2023 08:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com> <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
In-Reply-To: <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 16:08:32 +0100
Message-ID: <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
        error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 28, 2023 at 11:18=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> w=
rote:
>
> On Mon, Mar 20, 2023 at 3:48=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > Why would it break?  Is that because the test is buggy, or the kernel i=
s
> > buggy?
>
> This test will be fine, but there have been several times when
> selftests/bpf for stable kernel releases didn't actually compile due
> to backported tests. This is because macros we're redefined, etc.
> Unless those also get picked (seems like a sisyphean task) we'll keep
> seeing broken selftests/bpf on stable.

Hi Greg, Sasha,

Following up on this since it seems to have fallen through the cracks.

Lorenz
