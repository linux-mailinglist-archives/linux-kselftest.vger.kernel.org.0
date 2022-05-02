Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5C517280
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 May 2022 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351340AbiEBPax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 11:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbiEBPax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 11:30:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B126E13D5E
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 08:27:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w19so25822290lfu.11
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDyklUAoyTTdgVWsEoemT6UyP131z9n8RHUxpLnDQMY=;
        b=SzyK3k+kqpQoPf/tgtIS+0zQDny5U8m8BHUrxZ+605/6WUUaouMkBB7ioblO9uVvKe
         BBNBkkLqc9nUbsTX0148eSy2fT83S0K9IU8HLgWk4udmKEe6UtcBJj1PsN3ogzeqhQAf
         IBx2HUZy8DTe01ZOAaju7+UbHuv4Z40WMm2aq2fRTupDVqLpWmC2whkaiR9hsYgJeBRj
         nJyA3DAp8W57kW2dLH7rmMK0kFuBS4X1RRBKdrKopWLqoMY4hcAwHxnSQ+e25I1jBtb/
         Eh3odnad+9akNU3FAXt6V/R1hMatFOxm5XdxT7mxresYACgQBTsJ6pQMPRMjKOWFrsjx
         MWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDyklUAoyTTdgVWsEoemT6UyP131z9n8RHUxpLnDQMY=;
        b=eHgfqMbe9nRyjy4z7h+kTW9OoRCLe7p7HBoK4t1+j0TaNiL69qGVXZjaf9FG6KVz6K
         ISAODZVN23ju3vs7hwSxjWMC2cRBiwrrKKKYxkVrCpBdxaf3OHWUsEcwiHnKDpzn7ncJ
         LR4xF5kTEshZ9x+VO1jgdReJxjrJfv82ZN8obF5sKDg6AFIkM+cGHR/hLR/rdsaO2iZO
         EiaqTSdHWl7Yc8D1Q6xY9zdu1lOsph9lp7BCF55yGZJ/gCGy0rucsJm1UIXrdCHTemUI
         tXOCRKMjsM1Dn4d3h7tcvo/YZH/e9ua7v90dNCHqGi2w9K/M3I2t4U5tZI6xM1D94seW
         9ACg==
X-Gm-Message-State: AOAM532kNyt1A+iLe5ayy+t8hsaZkSa3970ISGfM23BaLGefK16GMaIq
        aqf9dmOta3M640JwdabBEzvPAuwDFcEVi4BqgCANQg==
X-Google-Smtp-Source: ABdhPJwVQHfBkm+C6rwJ9ibpEHrwiQ1RaDpbcsb72JhY/SSv/MQPziWyxN8JLn91CyJtOB+Zkr7kBD2SzvYAA0ZlZTU=
X-Received: by 2002:a05:6512:e86:b0:472:60c3:8430 with SMTP id
 bi6-20020a0565120e8600b0047260c38430mr5659726lfb.226.1651505241787; Mon, 02
 May 2022 08:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com> <20220429235644.697372-3-cmllamas@google.com>
In-Reply-To: <20220429235644.697372-3-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 2 May 2022 08:27:09 -0700
Message-ID: <CAHRSSEwExt0mjpAsX86qKJyFcwmTDCoVF9SY8G_f_PE8w9=gow@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] binder: add BINDER_GET_EXTENDED_ERROR ioctl
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 4:56 PM Carlos Llamas <cmllamas@google.com> wrote:
>
> Provide a userspace mechanism to pull precise error information upon
> failed operations. Extending the current error codes returned by the
> interfaces allows userspace to better determine the course of action.
> This could be for instance, retrying a failed transaction at a later
> point and thus offloading the error handling from the driver.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c            | 60 +++++++++++++++++++++++++++++
>  drivers/android/binder_internal.h   |  3 ++
>  include/uapi/linux/android/binder.h | 16 ++++++++
>  3 files changed, 79 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f0885baa53a1..b9df0c8a68d3 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -147,6 +147,13 @@ module_param_call(stop_on_user_error, binder_set_stop_on_user_error,
>                         binder_stop_on_user_error = 2; \
>         } while (0)
>
> +#define binder_set_extended_error(ee, _id, _command, _param) \
> +       do { \
> +               (ee)->id = _id; \
> +               (ee)->command = _command; \
> +               (ee)->param = _param; \
> +       } while (0)
> +
>  #define to_flat_binder_object(hdr) \
>         container_of(hdr, struct flat_binder_object, hdr)
>
> @@ -2697,6 +2704,24 @@ static struct binder_node *binder_get_node_refs_for_txn(
>         return target_node;
>  }
>
> +static void binder_set_txn_from_error(struct binder_transaction *t, int id,
> +                                     uint32_t command, int32_t param)
> +{
> +       struct binder_thread *from = binder_get_txn_from_and_acq_inner(t);
> +
> +       if (!from) {
> +               /* annotation for sparse */
> +               __release(&from->proc->inner_lock);
> +               return;
> +       }
> +
> +       /* don't override existing errors */
> +       if (from->ee.command == BR_OK)
> +               binder_set_extended_error(&from->ee, id, command, param);
> +       binder_inner_proc_unlock(from->proc);
> +       binder_thread_dec_tmpref(from);
> +}
> +
>  static void binder_transaction(struct binder_proc *proc,
>                                struct binder_thread *thread,
>                                struct binder_transaction_data *tr, int reply,
> @@ -2742,6 +2767,10 @@ static void binder_transaction(struct binder_proc *proc,
>         e->offsets_size = tr->offsets_size;
>         strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
>
> +       binder_inner_proc_lock(proc);
> +       binder_set_extended_error(&thread->ee, t_debug_id, BR_OK, 0);
> +       binder_inner_proc_unlock(proc);
> +
>         if (reply) {
>                 binder_inner_proc_lock(proc);
>                 in_reply_to = thread->transaction_stack;
> @@ -3487,10 +3516,16 @@ static void binder_transaction(struct binder_proc *proc,
>
>         BUG_ON(thread->return_error.cmd != BR_OK);
>         if (in_reply_to) {
> +               binder_set_txn_from_error(in_reply_to, t_debug_id,
> +                               return_error, return_error_param);
>                 thread->return_error.cmd = BR_TRANSACTION_COMPLETE;
>                 binder_enqueue_thread_work(thread, &thread->return_error.work);
>                 binder_send_failed_reply(in_reply_to, return_error);
>         } else {
> +               binder_inner_proc_lock(proc);
> +               binder_set_extended_error(&thread->ee, t_debug_id,
> +                               return_error, return_error_param);
> +               binder_inner_proc_unlock(proc);
>                 thread->return_error.cmd = return_error;
>                 binder_enqueue_thread_work(thread, &thread->return_error.work);
>         }
> @@ -4628,6 +4663,7 @@ static struct binder_thread *binder_get_thread_ilocked(
>         thread->return_error.cmd = BR_OK;
>         thread->reply_error.work.type = BINDER_WORK_RETURN_ERROR;
>         thread->reply_error.cmd = BR_OK;
> +       thread->ee.command = BR_OK;
>         INIT_LIST_HEAD(&new_thread->waiting_thread_node);
>         return thread;
>  }
> @@ -5066,6 +5102,25 @@ static int binder_ioctl_get_freezer_info(
>         return 0;
>  }
>
> +static int binder_ioctl_get_extended_error(struct binder_thread *thread,
> +                                          void __user *ubuf)
> +{
> +       struct binder_extended_error *ee = &thread->ee;
> +
> +       binder_inner_proc_lock(thread->proc);
> +       if (copy_to_user(ubuf, ee, sizeof(*ee))) {
> +               binder_inner_proc_unlock(thread->proc);
> +               return -EFAULT;
> +       }
> +
> +       ee->id = 0;
> +       ee->command = BR_OK;
> +       ee->param = 0;
> +       binder_inner_proc_unlock(thread->proc);
> +
> +       return 0;
> +}
> +
>  static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>         int ret;
> @@ -5274,6 +5329,11 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 binder_inner_proc_unlock(proc);
>                 break;
>         }
> +       case BINDER_GET_EXTENDED_ERROR:
> +               ret = binder_ioctl_get_extended_error(thread, ubuf);
> +               if (ret < 0)
> +                       goto err;
> +               break;
>         default:
>                 ret = -EINVAL;
>                 goto err;
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index d6b6b8cb7346..7c366a854125 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -480,6 +480,8 @@ struct binder_proc {
>   *                        (only accessed by this thread)
>   * @reply_error:          transaction errors reported by target thread
>   *                        (protected by @proc->inner_lock)
> + * @ee:                   extended error information from this thread
> + *                        (protected by @proc->inner_lock)
>   * @wait:                 wait queue for thread work
>   * @stats:                per-thread statistics
>   *                        (atomics, no lock needed)
> @@ -504,6 +506,7 @@ struct binder_thread {
>         bool process_todo;
>         struct binder_error return_error;
>         struct binder_error reply_error;
> +       struct binder_extended_error ee;
>         wait_queue_head_t wait;
>         struct binder_stats stats;
>         atomic_t tmp_ref;
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index 11157fae8a8e..e6ee8cae303b 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -236,6 +236,21 @@ struct binder_frozen_status_info {
>         __u32            async_recv;
>  };
>
> +/* struct binder_extened_error - extended error information
> + * @id:                identifier for the failed operation
> + * @command:   command as defined by binder_driver_return_protocol
> + * @param:     parameter holding a negative errno value
> + *
> + * Used with BINDER_GET_EXTENDED_ERROR. This extends the error information
> + * returned by the driver upon a failed operation. Userspace can pull this
> + * data to properly handle specific error scenarios.
> + */
> +struct binder_extended_error {
> +       __u32   id;
> +       __u32   command;
> +       __s32   param;
> +};
> +
>  #define BINDER_WRITE_READ              _IOWR('b', 1, struct binder_write_read)
>  #define BINDER_SET_IDLE_TIMEOUT                _IOW('b', 3, __s64)
>  #define BINDER_SET_MAX_THREADS         _IOW('b', 5, __u32)
> @@ -249,6 +264,7 @@ struct binder_frozen_status_info {
>  #define BINDER_FREEZE                  _IOW('b', 14, struct binder_freeze_info)
>  #define BINDER_GET_FROZEN_INFO         _IOWR('b', 15, struct binder_frozen_status_info)
>  #define BINDER_ENABLE_ONEWAY_SPAM_DETECTION    _IOW('b', 16, __u32)
> +#define BINDER_GET_EXTENDED_ERROR      _IOWR('b', 17, struct binder_extended_error)
>
>  /*
>   * NOTE: Two special error codes you should check for when calling
> --
> 2.36.0.464.gb9c8b46e94-goog
>
